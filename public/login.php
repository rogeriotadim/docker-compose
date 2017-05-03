<?php
require 'vendor/autoload.php';
$app = new Silex\Application();
$app['debug'] = true;

include 'bootstrap.php';

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Appch\Middleware\Logging as AppchLogging;
use Appch\Models\User;

$app ->get('/login/v1/login', function(Request $request) {
    $userRequest = $request->headers->get("php-auth-user");
    $passRequest = $request->headers->get("php-auth-pw");
    if($userRequest === null || $passRequest === null){
        return false;
    }

    $user = new User();
    $userLoged = $user->login($userRequest, $passRequest);
    if(!$userLoged){
        return false;
    }

    $payload = [];
    $payload[$userLoged->id] =
    [
        'username' => $userLoged->username,
        'id' => $userLoged->id,
        'email' => $userLoged->email
    ];

    return json_encode($payload, JSON_UNESCAPED_SLASHES);

});


$app->run();


?>