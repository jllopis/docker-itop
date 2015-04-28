Start up
========

1. Crear el contenedor de datos para la base de datos

$ docker create -v /var/lib/mysql --name ITOP_MARIADB_DATA mariadb

2. Crear la base de datos usando el contenedor anterior

$ docker run --name itop_db -e MYSQL_ROOT_PASSWORD=00000000 -e MYSQL_USER=itop -e MYSQL_PASSWORD=1234 -e MYSQL_DATABASE=itopdb -d --volumes-from ITOP_MARIADB_DATA -p 3306 mariadb

3. Crear un contenedor de datos para iTop

$ docker create -v /var/www/conf -v /var/www/data -v /var/www/env-production -v /var/www/log --name ITOP_DATA itop

4. Iniciar iTop enlazando la base de datos del paso 2 y el contenedor de datos del paso anterior

$ docker run -it --link itop_db:mysql --rm -p 80:80 --volumes-from ITOP_DATA itop

Se puede comprobar la base de datos con:

$ docker run -it --link itop_db:mysql --rm mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'

Se puede reiniciar e incluso actualizar tanto el contenedor **itop** como el de base de datos **mariadb**. Los datos quedan salvaguardados mientras no se eliminen los contenedores de datos **ITOP_MARIADB_DATA** e **ITOP_DATA**.
