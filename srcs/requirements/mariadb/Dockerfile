# Build a Docker image based on Alpine Linux version 3.16
FROM alpine:3.16

# Build-time variables stored in 'srcs/.env' and used to set up the MariaDB Docker container
ARG MYSQL_DATABASE MYSQL_ROOT_PASSWORD MYSQL_USER MYSQL_PASSWORD

# Update and upgrade the package index and install 'mariadb' and 'mariadb-client' packages without caching the downloaded packages
# 'mariadb' is a relational database management system that is a fork of the MySQL database server
# 'mariadb-client' provides a command-line client for connecting to and managing a MariaDB server
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

# The MariaDB Docker container will be able to receive incoming client connections on port 3306
EXPOSE 3306

# Copy 'mariadb.sh' from 'requirements/mariadb/conf/' to the current working directory of the MariaDB Docker container
COPY conf/db.sh .

# Execute and after remove 'mariadb.sh' which contains commands to install and configure the MariaDB server database
RUN sh db.sh && rm db.sh

# By default Docker containers run as the 'root' user
# Set the user context of the subsequent commands in the Dockerfile to the 'mysql' user to reduce the risk of security vulnerabilities
# The server process will run with lower privileges and will only access resources that the 'mysql' user has permission to access
USER mysql

# Set the default command to be executed when the MariaDB Docker container is started
# Start the MariaDB server process 'mysqld' with the '--skip-log-error' which tells the server to continue running even if there are errors writing to the log file
CMD ["mysqld"]
