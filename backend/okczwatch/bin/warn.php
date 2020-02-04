<?php

use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
require('helper.php');

define('BASE_PATH', dirname(__DIR__));

define('OK', 0);
define('WARN', 2);
define('FAILED', 3);

$db = new DbAdapter([
    'host'     => 'localhost',
    'username' => 'okczwatch',
    'password' => 'pUifZe6F77P1VADq',
    'dbname'   => 'okczwatch',
]);

$dt = new DateTime();
$dt->setTimezone(new DateTimeZone('Europe/Prague'));

// pole so zoznamom vsetkych taskov, ktore sa maju v tomto behu spracovat
// (zavisi hlavne na dennej hodine, kedy prioritne ulohy su spracovane kazdu hodinu,
// ale menej prioritne ulohy iba medzi 8 a 9hod)
$task = array();


// varovania podla uzivatela
$warnToSend = array();


/******************************************************************************
 *
 *  TASKS LIST
 *
 *  Nacitaj zoznam uloh, prioritu uloh a email adresu pre zaslanie varovania
 *
 ******************************************************************************/

$mday = (int)$dt->format('H');
if ($mday == 8) {
    // medzi 8:00 a 8:59 budu reportovane vsetky taky, prioritne i menej prioritne
    $sql = 'SELECT * FROM tasks';
    _log('[ STARTING AT ' . $dt->format('H:i') . ' - All tasks ]');
} else {
    // inak budu reportovane iba prioritne tasky
    $sql = 'SELECT * FROM tasks WHERE priority = 1';
    _log('[ STARTING AT ' . $dt->format('H:i') . ' - Only priority tasks ]');
}

// ziskame zoznam uloh, ktore budeme v tomto behu spracuvat - naplnime do pola $tasks
$res = $db->query($sql);
while ($row = $res->fetch()) {
    $taskCode = $row['task_code'];
    $taskPriority = $row['priority'];
    $taskWarnTo = $row['warn_email_to'];
    $description = $row['description'];
    $tasks[$taskCode] = array(
        'priority' => $taskPriority,
        'warn_email_to' => $taskWarnTo,
        'description' => $description
    );
    _log('Task: ' . $taskCode . '; priority: ' . $taskPriority . '; warn to: ' . $taskWarnTo);
}


/******************************************************************************
 *
 *  WARNING COLLECTOR
 *
 ******************************************************************************/

// neukoncene a chybove ulohy
$sql = 'SELECT * FROM task_log WHERE (st_code != 0 OR st_code IS NULL) AND warn_sent IS NULL';

_log('[ ------ TASK LOG WARNINGS ------ ]');
$res = $db->query($sql);
while ($row = $res->fetch()) {
    $idTaskLog = $row['id_task_log'];
    $taskCode = $row['task_code'];
    // preskoc ak na warningy tejto ulohy este neprisiel cas
    if (empty($tasks[$taskCode])) continue;
    $task = $tasks[$taskCode];

    // v db poli warn_email_to moze byt viac adresatov oddelenych ciarkami
    $warnEmailTo = $task['warn_email_to'];
    $warnEmailToArray = explode(',', $warnEmailTo);

    // prejdi vsetkych adresatov
    foreach ($warnEmailToArray as $email) {
        $email = trim($email);

        // zaloz pole pre prikladanie sprav adresatovi ak este neexistuje
        if (empty($warnToSend[$email])) $warnToSend[$email] = array();

        // task log
        $sqlTaskLog = 'SELECT * FROM log_item WHERE id_task_log = '.$idTaskLog;
        $resTaskLog = $db->query($sqlTaskLog);
        while ($rowTaskLog = $resTaskLog->fetch()) {

        }

        // pridaj hlasenie uzivatelovi
        $warnToSend[$email][] = array(
            'task_code' => $taskCode,
            'description' => $task['description'],
            'dt_created' => $row['dt_created'],
            'dt_finished' => $row['dt_finished'],
            'st_code' => $row['st_code'],
            'st_message' => $row['st_message'],
            'log' => 'Log...'
        );
    }

    _log($taskCode .' (id_task_log:' . $idTaskLog . ')');
}

if (DEBUG) print_r($warnToSend);


/******************************************************************************
 *
 *  WARNING EMAILER
 *
 ******************************************************************************/

_log('[ ------ SENDING EMAILS ------ ]');

foreach ($warnToSend as $email => $warnings) {
    _log('Preparing message for: ' . $email);
    $text = 'Report created at: ' . $dt->format('Y-m-d H:i:s') . "\n\n";

    foreach ($warnings as $warning) {
        $text .= "---------------------------------\n";
        $text .= 'Task started at: ' . $warning['dt_created'] . "\n";
        $text .= 'Task finished at: ' . ($warning['dt_finished'] ?? '!!! UNFINISHED !!!') . "\n\n";
        $text .= 'Task: ' . $warning['task_code'] . ' ( ' . $warning['description'] . " )\n\n";
        $text .= 'Return code: ' . ($warning['st_code'] ?? '!!! NULL !!!') . ' ' . $warning['st_message'] . "\n\n";
        $text .= $warning['log'] . "\n\n";
    }

    $to = $email;
    $subject = 'OKCZ Watch - ' . count($warnings) . ' warnings';
    $headers = "From: noreply@obalkyknih.cz";

    mail($to,$subject,$text,$headers);

    _log($text);
}

_log('[ ------ DONE ------ ]');
