#!/bin/bash

if [ ! -f "/var/www/wp-config.php" ]; then
	cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );
define( 'DB_HOST', '$MYSQL_HOST' );
define( 'DB_CHARSET', 'utf8' ); # standard charset
define( 'DB_COLLATE', '' ); # set collate to default (way data are stored and compared)
\$table_prefix = 'wp_'; # set the table prefix to wp_
define( 'WP_DEBUG', false );
define( 'FS_METHOD', 'direct' ); # allow WP to directly acces to the files, recommended if the file and website owner are the same person
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' ); #define absolute path for WP installation
}
require_once ABSPATH . 'wp-settings.php'; # load the configuration and settings file for WP
EOF
fi
