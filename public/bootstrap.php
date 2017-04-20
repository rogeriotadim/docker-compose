<?php
require 'vendor/autoload.php';

use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule();
$capsule->addConnection([
    "driver"     => "mysql",
    "host"       => "db",
    "database"   => "horaconta",
    "username"   => "horaconta",
    "password"   => "eno1s",
    "charset"    => "utf8",
    "collation"  => "utf8_general_ci"
]);

$capsule->bootEloquent();

?>