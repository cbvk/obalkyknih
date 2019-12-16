<?php

$router = $di->getRouter();

// Define your routes here
$router->add(
    '/logs',
    [
        'controller' => 'LogsController'
    ]
)->setName('logs');

$router->handle();
