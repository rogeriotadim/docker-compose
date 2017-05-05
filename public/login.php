<?php
require 'vendor/autoload.php';
$app = new Silex\Application();
$app['debug'] = true;

include 'bootstrap.php';

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Appch\Middleware\Logging as AppchLogging;
use Appch\Models\User;

$app ->get('/login/v1/login', function(Request $request)  use ($app) {
    $userRequest = $request->headers->get("php-auth-user");
    $passRequest = $request->headers->get("php-auth-pw");
    if($userRequest === null || $passRequest === null || $userRequest === '' || $passRequest === ''){
        $app->abort(401);
    }

    $user = new User();
    $userLoged = $user->login($userRequest, $passRequest);
    if(!$userLoged){
        return false;
    }

    $payload =
    [
        'username' => $userLoged->username,
        'id' => $userLoged->id,
        'email' => $userLoged->email,
        'apikey' => $userLoged->apikey
    ];

    return json_encode($payload, JSON_UNESCAPED_SLASHES);

});


$app->run();


?>