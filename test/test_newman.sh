docker run -it --link MariaDB --net contasdocasal_default -v $(pwd)/../src/flyway/sql:/var/massaTestes --rm mariadb sh -c 'exec mysql -hdb -uhoraconta -peno1s horaconta < /var/massaTestes/massa_testes.sql'

docker run -i -t --rm --add-host dev.php:10.0.2.15 -v $(pwd)/../test:/etc/newman postman/newman_ubuntu1404 --collection="postman_collection_v2.json" --environment="env.config"