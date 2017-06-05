<?php
require 'vendor/autoload.php';
$app = new Silex\Application();
$app['debug'] = true;

include 'bootstrap.php';

use Appch\Models\User;
use Appch\Models\Pagamento;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;

use Appch\Middleware\Logging as AppchLogging;
use Appch\Middleware\Authentication as AppchAuth;


$app->before(function($request, $app) {
        AppchLogging::log($request, $app);
        AppchAuth::authenticate($request, $app);
        // tratamento do 'Content-Type':'application/json'
        if (0 === strpos($request->headers->get('Content-Type'), 'application/json')) {
            $form = json_decode($request->getContent(), true);
            $request->request->replace(is_array($form) ? $form : array());

        }    
        
});

$app ->get('/', function() {
    return "123";
});

$app ->get('/hdc/v1/pagamento/comp/{competencia}', function($competencia)  use ($app) {
      
$pagamento = Pagamento::where('competencia', "=", $competencia)->get();

$payload = [];
foreach ($pagamento as $pagto){
        $payload[] =
        [
            'id' => $pagto->id,
            'descricao' => $pagto->descricao,
            'id_usuario' => $pagto->id_usuario,
            'created_at' => $pagto->created_at,
            'updated_at' => $pagto->updated_at,
            'data_pagto' => $pagto->data_pagto,
            'competencia' => $pagto->competencia,
            'valor' => $pagto->valor,
            'id_liquidacao' => $pagto->id_liquidacao,
            'id_parcelamento' => $pagto->id_parcelamento
        ];
 }
  return json_encode($payload, JSON_UNESCAPED_SLASHES);
});

$app ->get('/hdc/v1/pagamento/usuario/{id_usuario}', function($id_usuario)  use ($app) {
      
//$user = User::where('id', "=", $id_usuario)->take(1)->get()->pagamentos;
$pagamentos = User::find($id_usuario)->pagamentos;

$payload = [];
foreach ($pagamentos as $pagto){
        $payload[] =
        [
            'id' => $pagto->id,
            'descricao' => $pagto->descricao,
            'id_usuario' => $pagto->id_usuario,
            'created_at' => $pagto->created_at,
            'updated_at' => $pagto->updated_at,
            'data_pagto' => $pagto->data_pagto,
            'competencia' => $pagto->competencia,
            'valor' => $pagto->valor,
            'id_liquidacao' => $pagto->id_liquidacao,
            'id_parcelamento' => $pagto->id_parcelamento
        ];
 }
  return json_encode($payload, JSON_UNESCAPED_SLASHES);
});

$app ->get('/hdc/v1/pagamento', function(Request $request) {
      
//$pagamento = Pagamento::where('id_usuario', $request->attributes->get('userid'))->get();
$pagamento = Pagamento::all();

$payload = [];
foreach ($pagamento as $pagto){
        $payload[] =
        [
            'id' => $pagto->id,
            'descricao' => $pagto->descricao,
            'id_usuario' => $pagto->id_usuario,
            'created_at' => $pagto->created_at,
            'updated_at' => $pagto->updated_at,
            'data_pagto' => $pagto->data_pagto,
            'competencia' => $pagto->competencia,
            'valor' => $pagto->valor,
            'id_liquidacao' => $pagto->id_liquidacao,
            'id_parcelamento' => $pagto->id_parcelamento
        ];
 }
  return json_encode($payload, JSON_UNESCAPED_SLASHES);
});

$app->get('/hdc/v1/pagamento/{pagamento_id}', function($pagamento_id) use ($app) {
    
    $pagamento = Pagamento::where('id', $pagamento_id)->take(1)->get();
    //$pagamento = Pagamento::where('id', $pagamento_id)->get();
    foreach ($pagamento as $pagto){
        $payload = 
            [
                'id' => $pagto->id,
                'descricao' => $pagto->descricao,
                'id_usuario' => $pagto->id_usuario,
                'created_at' => $pagto->created_at,
                'updated_at' => $pagto->updated_at,
                'data_pagto' => $pagto->data_pagto,
                'competencia' => $pagto->competencia,
                'valor' => $pagto->valor,
                'id_liquidacao' => $pagto->id_liquidacao,
                'id_parcelamento' => $pagto->id_parcelamento
            ];
        
    }

    return json_encode($payload, JSON_UNESCAPED_SLASHES);
});

$app->post('/hdc/v1/pagamento', function(Request $request) use ($app) {
    $idUsuario = $request->request->get('id_usuario');
    $descricao = $request->request->get('descricao');
    $dataPagamento = $request->request->get('data_pagto');
    $competencia = $request->request->get('competencia');
    $valor = $request->request->get('valor');

    $pagamento = new Pagamento();
    $pagamento->descricao = $descricao;
    $pagamento->id_usuario = $idUsuario;
    $pagamento->data_pagto = $dataPagamento;
    $pagamento->competencia = $competencia;
    $pagamento->valor = $valor;
    
    $pagamento->save();

    if ($pagamento->id) {
        $payload = ['id' => $pagamento->id, 'pagamento_uri' => '/hdc/v1/pagamento/' . $pagamento->id];
        $code = 201;
    } else {
        $code = 400;
        $payload = [];
    }

    return $app->json($payload, $code);
});

$app->put('/hdc/v1/pagamento/{pagamento_id}', function($pagamento_id, Request $request) use ($app) {
    
    $descricao = $request->request->get('descricao');
    $dataPagamento = $request->request->get('data_pagto');
    $competencia = $request->request->get('competencia');
    $valor = $request->request->get('valor');

    $pagamento = Pagamento::find($pagamento_id);

    $code = 0;

    if($pagamento->id_liquidacao){
        $code = Response::HTTP_BAD_REQUEST;
        $header = array('X-Status-Code' => $code);
        $payload = ['mensagem_de_erro' => 'pagamento_liquidado', 'id_liquidacao' => $pagamento->id_liquidacao];
    }

    if(!$pagamento->id){
        $code = Response::HTTP_BAD_REQUEST;
        $header = array('X-Status-Code' => $code);
        $payload = ['mensagem_de_erro' => 'pagamento_nao_encontrado'];
    }

    if($code === 0) {
        $pagamento->descricao = $descricao;
        $pagamento->dataPagamento = $dataPagamento;
        $pagamento->competencia = $competencia;
        $pagamento->valor = $valor;
    
        $pagamento->save();

        $code = Response::HTTP_OK;
        $header = array('X-Status-Code' => $code);
        $payload = ['pagamento_id' => $pagamento->id, 'pagamento_uri' => '/hdc/v1/pagamento/' . $pagamento->id];
    }


    $jsonResp = JsonResponse::create($payload, $code, $header);
    $jsonResp->setStatusCode($code);
    return $jsonResp;
    // return JsonResponse::create(['message' => 'error'], 401)->setStatusCode(Response::HTTP_BAD_REQUEST);
    // return $app->json(array('mensagem_de_erro' => 'pagamento_nao_encontrado'), 400);
});

$app->delete('/hdc/v1/pagamento/{pagamento_id}', function($pagamento_id) use ($app) {
    $pagamento = Pagamento::find($pagamento_id);

    $code = 0;

    if($pagamento->id_liquidacao){
        $code = Response::HTTP_BAD_REQUEST;
        $header = array('X-Status-Code' => $code);
        $payload = ['mensagem_de_erro' => 'pagamento_liquidado', 'id_liquidacao' => $pagamento->id_liquidacao];
    }

    if($pagamento->id_parcelamento){
        $code = Response::HTTP_BAD_REQUEST;
        $header = array('X-Status-Code' => $code);
        $payload = ['mensagem_de_erro' => 'pagamento_de_parcelamento', 'id_parcelamento' => $pagamento->id_parcelamento];
    }

    if(!$pagamento->id){
        $code = Response::HTTP_NOT_FOUND;
        $header = array('X-Status-Code' => $code);
        $payload = ['mensagem_de_erro' => 'pagamento_nao_encontrado'];
    }

    if($code === 0) {
    
        $pagamento->delete();

        $code = Response::HTTP_OK;
        $payload = ['pagamento_id' => $pagamento->id, 'situacao' => 'deletado'];
    }
    
    $jsonResp = JsonResponse::create($payload, $code, $header);
    $jsonResp->setStatusCode($code);
    return $jsonResp;

});


$app->run();


?>