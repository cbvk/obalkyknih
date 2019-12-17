<?php

use Phalcon\Mvc\Model\Query;

class TaskController extends ControllerBase
{

    public function findAction()
    {
        $this->view->disable();
        $request =$this->request;
        if ($request->isGet()==true) {
                if ($request->isAjax() == true) {
                        $task = $_GET["task"];
                        $query = new Query(
                            'SELECT * FROM Tasks WHERE task_code = :task: LIMIT 1',
                            $this->di
                        );
                        $res = $query->execute(
                            [
                                'task' => $task
                            ]
                        );
                        foreach ($res as $r) {
                            echo '<label for="task_code">Název úlohy</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="task_code" class="form-control validate" value="', $r->task_code, '">';
                            echo '</div>';

                            echo '<label for="description">Popis</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="description" class="form-control validate" value="', $r->description, '">';
                            echo '</div>';
                            
                            
                            echo '<label for="priority">Popis</label>';
                            echo '<div class="input-group mb-5">';
                            echo '<select class="custom-select" id="priority">';
                            if ($r->priority == 1){echo '<option value="1" selected="selected">Nízka</option>';}
                            else {echo '<option value="1">Nízka</option>';}
                            if ($r->priority == 2){echo '<option value="2" selected="selected">Střední</option>';}
                            else {echo '<option value="2">Střední</option>';}
                            if ($r->priority == 3){echo '<option value="3" selected="selected">Vysoká</option>';}
                            else {echo '<option value="3">Vysoká</option>';}
                            echo '</select>';
                            echo '</div>';

                            echo '<label for="warn_email_to">Email varování</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="warn_email_to" class="form-control validate" value="', $r->warn_email_to, '">';
                            echo '</div>';

                            echo '<label for="warn_sms_to">SMS varování</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="warn_sms_to" class="form-control validate" value="', $r->warn_sms_to, '">';
                            echo '</div>';

                            echo '<label for="exec_script">Script</label>';
                            echo '<div class="input-group mb-5">';
                            echo '<select class="custom-select" id="exec_script">';
                            if ($r->exec_script == 1){echo '<option value="1" selected="selected">Nízka</option>';}
                            else {echo '<option value="1">Nízka</option>';}
                            if ($r->exec_script == 2){echo '<option value="2" selected="selected">Střední</option>';}
                            else {echo '<option value="2">Střední</option>';}
                            if ($r->exec_script == 3){echo '<option value="3" selected="selected">Vysoká</option>';}
                            else {echo '<option value="3">Vysoká</option>';}
                            echo '</select>';
                            echo '</div>';

                            echo '<label for="task_schedule_type">Zpuštet</label>';
                            echo '<div class="input-group mb-5">';
                            echo '<select class="custom-select" id="task_schedule_type">';
                            if ($r->task_schedule_type == 1){echo '<option value="1" selected="selected">Pozastavené</option>';}
                            else {echo '<option value="1">Pozastavené</option>';}
                            if ($r->task_schedule_type == 2){echo '<option value="2" selected="selected">V definovanou dobu</option>';}
                            else {echo '<option value="2">V definovanou dobu</option>';}
                            if ($r->task_schedule_type == 3){echo '<option value="3" selected="selected">Po úloze</option>';}
                            else {echo '<option value="3">Po úloze</option>';}
                            echo '</select>';
                            echo '</div>';
                            
                            echo '<label for="hours_start">Hodiny</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="hours_start" class="form-control validate" value="', $r->hours_start, '">';
                            echo '</div>';

                            echo '<label for="minutes_start">Minuty</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="minutes_start" class="form-control validate" value="', $r->minutes_start, '">';
                            echo '</div>';

                            echo '<label for="task_code_prev">Po úloze</label>';
                            echo '<div class="input-group mb-5">';
                            echo '<select class="custom-select" id="task_code_prev">';
                            if ($r->task_code_prev == 1){echo '<option value="1" selected="selected">Nízka</option>';}
                            else {echo '<option value="1">Nízka</option>';}
                            if ($r->task_code_prev == 2){echo '<option value="2" selected="selected">Střední</option>';}
                            else {echo '<option value="2">Střední</option>';}
                            if ($r->task_code_prev == 3){echo '<option value="3" selected="selected">Vysoká</option>';}
                            else {echo '<option value="3">Vysoká</option>';}
                            echo '</select>';
                            echo '</div>';

                            echo '<label for="minutes_duration">Max doba</label>';
                            echo '<div class="md-form mb-5">';
                            echo '<input type="text" id="minutes_duration" class="form-control validate" value="', $r->minutes_duration, '">';
                            echo '</div>';
                        }
                }
            }
    }

}
