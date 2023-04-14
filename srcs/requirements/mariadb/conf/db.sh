#!/bin/bash

if [ ! -d "/var/run/mysqld" ]; then
        mkdir -p /var/run/mysqld
        chown -R mysql:mysql /var/run/mysqld
fi

if [ ! -d "/etc/my.cnf.d" ]; then
        mkdir -p /etc/my.cnf.d
        chown -R mysql:mysql /etc/my.cnf.d
fi

echo '[mysqld]' > /etc/my.cnf.d/docker.cnf
# skip cache for performances issue
echo 'skip-host-cache' >> /etc/my.cnf.d/docker.cnf
echo 'skip-name-resolve' >> /etc/my.cnf.d/docker.cnf
echo 'bind-address=0.0.0.0' >> /etc/my.cnf.d/docker.cnf
# allow users to log into the DB
sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf


if [ ! -d "/var/lib/mysql/mysql" ]; then
        chown -R mysql:mysql /var/lib/mysql
        mysql_install_db --user=mysql --datadir=/var/lib/mysql --basedir=/usr --rpm
        tempfile=`mktemp`
        if [ ! -f "$tempfile" ]; then
                return 1
        fi
fi

# removes the default test database and user and deletes any empty users from the MySQL database
# setup passwords of user and root user with ARG provided in the Dockerfile
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
fi
