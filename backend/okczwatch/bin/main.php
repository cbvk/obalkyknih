<?php

use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
require('helper.php');

define('BASE_PATH', dirname(__DIR__));

define('OK', 0);
define('WARN', 2);
define('FAILED', 3);

// Set the database service
$db = new DbAdapter([
    'host'     => 'localhost',
    'username' => 'okczwatch',
    'password' => 'pUifZe6F77P1VADq',
    'dbname'   => 'okczwatch',
]);

$sql = 'SELECT * FROM tasks';
$res = $db->query($sql);

while ($row = $res->fetch()) {

    // podmienky spustenia

    // naloaduje modul
    $taskCode = $row['task_code'];
    _log('[ ------ STARTING TASK: ' . $taskCode .' ------ ]');
    include(BASE_PATH . '/bin/modules/' . $taskCode . '.php');

    // zaloguj start
    $dbLogRes = $db->insert(
        'task_log',
        [$taskCode],
        ['task_code']
    );
    $idTaskLog = $db->lastInsertId();

    // vykonaj
    $func = array($taskCode, 'main');
    $funcRes = $func($db);
    $funcResCode = $funcRes[0];
    $funcResMessage = $funcRes[1];

    // zaloguj koniec
    $dbLogRes = $db->update(
        'task_log',
        ['dt_finished', 'st_code', 'st_message'],
        [date('Y-m-d H:i:s'), $funcResCode, $funcResMessage],
        'id_task_log = '.$idTaskLog
    );

    _log('[ ' . $taskCode .' = ' . $funcResCode . ' (' . $funcResMessage . ') ]');
}

_log('[ ------ DONE ------ ]');
