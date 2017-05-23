# contas-do-casal
PHP applications using Nginx, phpMyAdmin, MariaDB and PHP7-FPM and Composer.

* Add host name(dev.php) in the /etc/hosts file

* Build docker composer image:
    $ docker build -t composer_dev:latest ./src/composer/

* Run `docker-compose up`

* Composer example command:
    $ docker run --rm -v $(pwd):/app composer_dev require illuminate/database 5.2

* Flyway
    $ docker run --rm -v $(pwd)/src/flyway/sql:/flyway/sql dhoer/flyway:4.1.2-mariadb-1.5.9 -url=jdbc:mariadb://ip:3366/dbname -user=username -password=password migrate

* Newman
    $ docker run -i -t --rm --add-host dev.php:<iplocal> -v $(pwd)/test:/etc/newman postman/newman_ubuntu1404 --collection="postman_collection_v2.json" --environment="env.config"

* Mariadb - execute sql
$ docker run -it --link MariaDB --net contasdocasal_default -v $(pwd):/var/massaTestes --rm mariadb sh -c 'exec mysql -hdb -uhoraconta -peno1s horaconta < /var/massaTestes/cleanup.sql' 

$ docker run -it --link MariaDB --net contasdocasal_default -v $(pwd):/var/massaTestes --rm mariadb sh -c 'exec mysql -hdb -uhoraconta -peno1s horaconta < /var/massaTestes/massa_testes.sql'


curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: d0763edaa9d9bd2a9516280e9044d885" -X GET http://dev.php/hdc/v1/pagamento/108??????



