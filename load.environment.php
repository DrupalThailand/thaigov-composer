<?php


use Dotenv\Dotenv;

/**
 * Load any .env file. See /.env.example.
 *
 * Drupal has no official method for loading environment variables and uses
 * getenv() in some places.
 */
$dotenv = Dotenv::createUnsafeImmutable(__DIR__);
$dotenv->safeLoad();
