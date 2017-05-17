<?php
require 'vendor/autoload.php';
$app = new Silex\Application();
$app['debug'] = true;

include 'bootstrap.php';

use Appch\Models\User;
use Appch\Models\Pagamento;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

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
            'update_at' => $pagto->update_at,
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
            'update_at' => $pagto->update_at,
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
            'update_at' => $pagto->update_at,
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
                'update_at' => $pagto->update_at,
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
    $_pagamento = $request->get('pagamento');
    $pagamento = Pagamento::find($pagamento_id);
    $pagamento->body = $_pagamento;

  
   
    $pagamento->save();

    if ($pagamento->id) {
        $payload = ['pagamento_id' => $pagamento->id, 'pagamento_uri' => '/pagamentos/' . $pagamento->id];
        $code = 201;
    } else {
        $code = 400;
        $payload = [];
    }

    return $app->json($payload, $code);
});
$app->delete('/hdc/v1/pagamento/{pagamento_id}', function($pagamento_id) use ($app) {
    $pagamento = Pagamento::find($pagamento_id);
    $pagamento->delete();

    if ($pagamento->exists) {
        return new Response('', 400);
    } else {
        return new Response('Your pagamento is deleted', 204);
    }
});


$app->run();


?>