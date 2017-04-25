<?php

namespace Appch\Middleware;

class Configuration {

    public function getApiKey() {

        $config_array = parse_ini_file(__DIR__ . "/../Config/config.ini.php");
        $apiKeyConfig = $config_array['apikey'];

        return $apiKeyConfig;
    }
}
?>