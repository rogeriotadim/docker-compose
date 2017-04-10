# contas-do-casal
PHP applications using Nginx, phpMyAdmin, MariaDB and PHP7-FPM and Composer.

* Add host name(dev.php) in the /etc/hosts file

* Build docker composer image:
    $ docker build -t composer_dev:latest ./src/composer/

* Run `docker-compose up`

* Composer example command:
    $ docker run --rm -v $(pwd):/app composer_dev require illuminate/database 5.2


