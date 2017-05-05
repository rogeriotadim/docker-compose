<?php
require 'vendor/autoload.php';
$app = new Silex\Application();
$app['debug'] = true;

include 'bootstrap.php';

use Appch\Models\Pagamento;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Appch\Middleware\Logging as AppchLogging;
use Appch\Middleware\Authentication as AppchAuth;
use Appch\Models\User;

$app->before(function($request, $app) {
        AppchLogging::log($request, $app);
        AppchAuth::authenticate($request, $app);
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
   // $_pagamento = $request->get('pagamento');
    $pagamento = Pagamento::where('id', $pagamento_id)->take(1)->get();
    //$pagamento = new Pagamento();

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

    return json_encode($payload, JSON_UNESCAPED_SLASHES);
});

$app->post('/hdc/v1/pagamento', function(Request $request) use ($app) {
    $_pagamento = $request->get('pagamento');
    $pagamento = new Pagamento();
    $pagamento->descricao = $_pagamento;
    $pagamento->id_usuario = $request->attributes->get('idusuario');
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