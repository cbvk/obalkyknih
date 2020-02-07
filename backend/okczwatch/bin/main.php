<?php

use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
require('helper.php');

define('BASE_PATH', dirname(__DIR__));

define('OK', 0);
define('WARN', 2);
define('FAILED', 3);
date_default_timezone_set('Europe/Prague');

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
    $task_schedule_type = $row['task_schedule_type'];
    $taskCode = $row['task_code'];
    $test_day = date('d.m.Y G:i', strtotime("today"));
    _log("$test_day");
    continue;
    if ($task_schedule_type == 1) continue;
    elseif ($task_schedule_type == 2) {
        $hours_start = $row['hours_start'];
        $hours_start = explode(',', $hours_start);
        $minutes_start = $row['minutes_start'];
        $minutes_start = explode(',', $minutes_start);
        $week_days = $row['week_days'];

        $hour_now = date("H");
        $minute_now = date("i");
        $day_now = date("N");
        // _log("$week_days[0]");
        // _log("$day_now");
        if ($week_days[$day_now-1] == '0') continue;
        // _log('[ hour now: ' . $hour_now . ' minute now: ' . $minute_now . ' ]');
        $is_time = FALSE;
        foreach ($hours_start as $hour) {
            foreach ($minutes_start as $minute) {
                // _log('[ hour: ' . $hour . ' minute: ' . $minute . ' ]');
                if ($hour == $hour_now and $minute == $minute_now) {
                    $is_time = TRUE;
                    break;
                }
            }
            if ($is_time) break;
        }
        if (! $is_time) continue;
    }
    elseif ($task_schedule_type == 3){
        $task_code_prev = $row['task_code_prev'];
        $sql_prev = "SELECT * FROM `task_log` WHERE `task_code` = '$task_code_prev'  ORDER BY `task_log`.`dt_finished`  DESC LIMIT 1";
        $last_run_prev = $db->fetchOne($sql_prev); 

        $sql_last_run = "SELECT * FROM `task_log` WHERE `task_code` = '$taskCode' ORDER BY `task_log`.`dt_created` DESC LIMIT 1";
        $last_run = $db->fetchOne($sql_last_run);
        if ($last_run['dt_created'] >= $last_run_prev['dt_finished']) continue;

        // _log('last run prev task code ' . $last_run_prev['task_code'] . ' finished ' . $last_run_prev['dt_finished'] . ' id ' . $last_run_prev['id_task_log']);
    }
    else continue;
    

    // naloaduje modul
    
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
