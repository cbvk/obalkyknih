<?php

class IndexController extends ControllerBase
{

    /**
     * Zoznam uloh
     */
    public function indexAction()
    {
        $this->view->tasks = Tasks::find();
        date_default_timezone_set('Europe/Prague');
        $next_run = array();
        $last_run = array();
        $debug = "";
        foreach ($this->view->tasks as $task) {
            if ($task->task_schedule_type == 2) {
                $week_days = $task->week_days;
                $hours = $task->hours_start;
                $minutes = $task->minutes_start;
                $hours = explode(',', $hours);
                $minutes = explode(',', $minutes);
                $nearest_date = strtotime("now + 2 week");
                $date_now = time();
                $hour_now = date("H");
                $minute_now = date("i");
                $nearest_hour = "24";
                foreach ($hours as $h) {
                    $debug = $debug . "h: $h";
                    if ($h < $nearest_hour and $h >= $hour_now) {
                        $nearest_hour = $h;
                    }
                }
                
                $nearest_minute = 59;
                foreach ($minutes as $m) {
                    if ($m < $nearest_minute and $m >= $minute_now) {
                        $nearest_minute = $m;
                    }
                }
                $debug = $debug . "hour: $nearest_hour" . "minute: $nearest_minute";

                if ($week_days[0] == '1') {
                    // $debug = 'som tu';
                    $date = strtotime("next Monday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '1') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                // $debug = date('d.m.Y G:i', $nearest_date);
                if ($week_days[1] == '1') {
                    $date = strtotime("next Tuesday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '2') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[2] == '1') {
                    $date = strtotime("next Wednesday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '3') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[3] == '1') {
                    $date = strtotime("next Thursday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '4') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        $debug = $debug . " thursday: $date ";
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[4] == '1') {
                    $date = strtotime("next Friday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '5') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[5] == '1') {
                    $date = strtotime("next Saturday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '6') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[6] == '1') {
                    $date = strtotime("next Sunday  $nearest_hour:$nearest_minute");
                    $debug = $debug . " next: $date ";
                    if ($date < $nearest_date and $date >= $date_now) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '7') {
                        $date = strtotime("now $nearest_hour:$nearest_minute");
                        if ($date >= $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                $next_run[$task->task_code] = date('d.m.Y G:i', $nearest_date);
            }
            elseif ($task->task_schedule_type == 3) {
                $next_run[$task->task_code] = $task->task_code_prev;
            }
            else {
                $next_run[$task->task_code] = 'Pozastavena';
            } 

            $res = $this->modelsManager->executeQuery('SELECT st_code, dt_finished FROM TaskLog WHERE task_code = :task_code: ORDER BY dt_finished DESC LIMIT 1',
                                                        [
                                                            'task_code' => $task->task_code
                                                        ])->getFirst();
            if ($res == NULL) {
                $last_run[$task->task_code] = 'Not started';
            }
            else {
                if ($res->st_code == 0){
                    $last_run[$task->task_code] = 'OK';
                }
                else {
                    $last_run[$task->task_code] = 'FAILED';
                }
            }
        }
        $this->view->next_run = $next_run;
        $this->view->last_run = $last_run;
        $this->view->debug = $debug;
    }

}

