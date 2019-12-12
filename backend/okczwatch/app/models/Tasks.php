<?php

use Phalcon\Mvc\Model;

class Tasks extends Model
{
    public $task_code;
    public $description;
    public $priority;
    public $warn_email_to;
    public $warn_sms_to;
    public $exec_script;
    public $task_schedule_type;
    public $week_days;
    public $task_code_prev;
    public $hours_start;
    public $minutes_start;
    public $minutes_duration;
}
