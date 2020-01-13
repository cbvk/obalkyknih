<?php

class IndexController extends ControllerBase
{

    /**
     * Zoznam uloh
     */
    public function indexAction()
    {
        $this->view->tasks = Tasks::find();
        $next_run = array();
        $last_run = array();
        $debug = "";
        foreach ($this->view->tasks as $task) {
            if ($task->task_schedule_type == 2) {
                $week_days = $task->week_days;
                $hours = $task->hours_start;
                $minutest = $task->minutes_start;
                $nearest_date = strtotime("+ 2 week");
                $date_now = time();
                if ($week_days[0] == '1') {
                    $debug = 'som tu';
                    $date = strtotime("next Monday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '1') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                // $debug = date('d.m.Y G:i', $nearest_date);
                if ($week_days[1] == '1') {
                    $date = strtotime("next Tuesday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '2') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[2] == '1') {
                    $date = strtotime("next Wednesday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '3') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[3] == '1') {
                    $date = strtotime("next Thursday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '4') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[4] == '1') {
                    $date = strtotime("next Friday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '5') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[5] == '1') {
                    $date = strtotime("next Saturday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '6') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
                            $nearest_date = $date;
                        }
                    }
                }
                if ($week_days[6] == '1') {
                    $date = strtotime("next Sunday  $hours:$minutest");
                    if ($date < $nearest_date) {
                        $nearest_date = $date;
                    }
                    if (date('N', $date_now) == '7') {
                        $date = strtotime("now $hours:$minutest");
                        if ($date > $date_now and $date < $nearest_date) {
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

            // SELECT `st_code`, `dt_finished` FROM `task_log` WHERE `task_code` = 'test' ORDER BY `dt_finished` DESC LIMIT 1 

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

