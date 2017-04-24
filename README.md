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


