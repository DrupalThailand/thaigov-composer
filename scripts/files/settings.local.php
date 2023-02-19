<?php
// Databaes Setup
$databases['default']['default'] = [
   'database' => getenv('MYSQL_DATABASE'),
   'driver' => 'mysql',
   'host' => getenv('MYSQL_HOSTNAME'),
   'username' => getenv('MYSQL_USER'),
   'password' => getenv('MYSQL_PASSWORD'),
   'port' => getenv('MYSQL_PORT'),
   'prefix' => '',
   'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
];

$settings['config_sync_directory'] = '../config/sync';