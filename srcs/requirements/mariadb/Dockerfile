FROM alpine:3.16

ARG MYSQL_DATABASE MYSQL_ROOT_PASSWORD MYSQL_USER MYSQL_PASSWORD

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

EXPOSE 3306

COPY conf/db.sh .

RUN sh db.sh && rm db.sh

# Set the default user to the 'mysql' user to reduce the risk of security vulnerabilities
USER mysql

CMD ["mysqld"]
