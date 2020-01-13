<?php

use Phalcon\Mvc\Model\Query;
use Phalcon\Mvc\Model\Manager;

class TaskController extends ControllerBase
{

    public function findAction()
    {
        // TODO presunut do view alebo layoutu
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
                        
                        $query_scripts = new Query(
                            'SELECT Scripts.id_script, Scripts.script_name FROM Scripts WHERE 1',
                            $this->di
                        );
                        $res_scripts = $query_scripts->execute();

                        $query_other = new Query(
                            'SELECT Tasks.task_code FROM Tasks WHERE Tasks.task_code != :task:',
                            $this->di
                        );
                        $res_other = $query_other->execute(
                            [
                                'task' => $task
                            ]
                        );

                        foreach ($res as $r) {
                            echo '<form>';
                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="task_code" class="col-sm-3 col-form-label">Název úlohy</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="task_code" type="text" id="task_code" class="form-control validate" value="', $r->task_code, '">';
                            echo '</div>';
                            echo '</div>';

                            
                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="description" class="col-sm-3 col-form-label">Popis</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="description" type="text" id="description" class="form-control validate" value="', $r->description, '">';
                            echo '</div>';
                            echo '</div>';
                            
                            
                            echo '<div class="input-group mb-5 row">';
                            echo '<label for="priority" class="col-sm-3 col-form-label">Priorita</label>';
                            echo '<div class="col-sm-9">';
                            echo '<select name="priority" class="custom-select" id="priority">';
                            if ($r->priority == 1){echo '<option value="1" selected="selected">Nízka</option>';}
                            else {echo '<option value="1">Nízka</option>';}
                            if ($r->priority == 2){echo '<option value="2" selected="selected">Střední</option>';}
                            else {echo '<option value="2">Střední</option>';}
                            if ($r->priority == 3){echo '<option value="3" selected="selected">Vysoká</option>';}
                            else {echo '<option value="3">Vysoká</option>';}
                            echo '</select>';
                            echo '</div>';
                            echo '</div>';

                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="warn_email_to" class="col-sm-3 col-form-label">Email varování</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="warn_email_to" type="text" id="warn_email_to" class="form-control validate" value="', $r->warn_email_to, '">';
                            echo '</div>';
                            echo '</div>';

                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="warn_sms_to" class="col-sm-3 col-form-label">SMS varování</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="warn_sms_to" type="text" id="warn_sms_to" class="form-control validate" value="', $r->warn_sms_to, '">';
                            echo '</div>';
                            echo '</div>';

                            
                            echo '<div class="input-group mb-5 row">';
                            echo '<label for="exec_script" class="col-sm-3 col-form-label">Script</label>';
                            echo '<div class="col-sm-9">';
                            echo '<select name="exec_script" class="custom-select" id="exec_script">';
                            foreach ($res_scripts as $script) {
                                if ($r->exec_script == $script->id_script){echo '<option value="', $script->id_script, '" selected="selected">', $script->script_name, '</option>';}
                                else {echo '<option value="', $script->id_script, '">', $script->script_name, '</option>';}
                            }
                            echo '</select>';
                            echo '</div>';
                            echo '</div>';

                            
                            echo '<div class="input-group mb-5 row">';
                            echo '<label for="task_schedule_type" class="col-sm-3 col-form-label">Zpuštet</label>';
                            echo '<div class="col-sm-9">';
                            echo '<select name="task_schedule_type" class="custom-select" id="task_schedule_type">';
                            if ($r->task_schedule_type == 1){echo '<option value="1" selected="selected">Pozastavené</option>';}
                            else {echo '<option value="1">Pozastavené</option>';}
                            if ($r->task_schedule_type == 2){echo '<option value="2" selected="selected">V definovanou dobu</option>';}
                            else {echo '<option value="2">V definovanou dobu</option>';}
                            if ($r->task_schedule_type == 3){echo '<option value="3" selected="selected">Po úloze</option>';}
                            else {echo '<option value="3">Po úloze</option>';}
                            echo '</select>';
                            echo '</div>';
                            echo '</div>';
                            
                            
                            echo '<div class="input-group mb-5 row" id="days">';
                            echo '<label for="days" class="col-sm-3 col-form-label">Dni v týdnu</label>';
                            echo '<div class="col-sm-9">';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            if ($r->week_days[0] == '1') {echo '<input name="checkbox_monday" class="form-check-input" type="checkbox" id="checkbox_monday" checked>';}
                            else {echo '<input name="checkbox_monday" class="form-check-input" type="checkbox" id="checkbox_monday">';}
                            echo '<label for="checkbox_monday">Po</label>';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            echo '</div>';
                            if ($r->week_days[1] == '1') {echo '<input name="checkbox_tuesday" class="form-check-input" type="checkbox" id="checkbox_tuesday" checked>';}
                            else {echo '<input name="checkbox_tuesday" class="form-check-input" type="checkbox" id="checkbox_tuesday">';}
                            echo '<label for="checkbox_tuesday">Út</label>';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            echo '</div>';
                            if ($r->week_days[2] == '1') {echo '<input name="checkbox_wednesday" class="form-check-input" type="checkbox" id="checkbox_wednesday" checked>';}
                            else {echo '<input name="checkbox_wednesday" class="form-check-input" type="checkbox" id="checkbox_wednesday">';}
                            echo '<label for="checkbox_wednesday">St</label>';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            echo '</div>';
                            if ($r->week_days[3] == '1') {echo '<input name="checkbox_thursday" class="form-check-input" type="checkbox" id="checkbox_thursday" checked>';}
                            else {echo '<input name="checkbox_thursday" class="form-check-input" type="checkbox" id="checkbox_thursday">';}
                            echo '<label for="checkbox_thursday">Čt</label>';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            echo '</div>';
                            if ($r->week_days[4] == '1') {echo '<input name="checkbox_friday" class="form-check-input" type="checkbox" id="checkbox_friday" checked>';}
                            else {echo '<input name="checkbox_friday" class="form-check-input" type="checkbox" id="checkbox_friday">';}
                            echo '<label for="checkbox_friday">Pá</label>';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            echo '</div>';
                            if ($r->week_days[5] == '1') {echo '<input name="checkbox_saturday" class="form-check-input" type="checkbox" id="checkbox_saturday" checked>';}
                            else {echo '<input name="checkbox_saturday" class="form-check-input" type="checkbox" id="checkbox_saturday">';}
                            echo '<label for="checkbox_saturday">So</label>';
                            echo '<div class="form-group mb-5 form-check-inline">';
                            echo '</div>';
                            if ($r->week_days[6] == '1') {echo '<input name="checkbox_sunday" class="form-check-input" type="checkbox" id="checkbox_sunday" checked>';}
                            else {echo '<input name="checkbox_sunday" class="form-check-input" type="checkbox" id="checkbox_sunday">';}
                            echo '<label for="checkbox_sunday">Ne</label>';
                            echo '</div>';
                            echo '</div>';
                            echo '</div>';
                            
                            
                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="hours_start" class="col-sm-3 col-form-label">Hodiny</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="hours_start" type="text" id="hours_start" class="form-control validate" value="', $r->hours_start, '">';
                            echo '</div>';
                            echo '</div>';

                            
                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="minutes_start" class="col-sm-3 col-form-label">Minuty</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="minutes_start" type="text" id="minutes_start" class="form-control validate" value="', $r->minutes_start, '">';
                            echo '</div>';
                            echo '</div>';

                            
                            echo '<div class="input-group mb-5 row">';
                            echo '<label for="task_code_prev" class="col-sm-3 col-form-label">Po úloze</label>';
                            echo '<div class="col-sm-9">';
                            echo '<select name="task_code_prev" class="custom-select" id="task_code_prev">';
                            if ($r->task_code_prev == NULL){echo '<option value="', NULL, '" selected="selected">NULL</option>';}
                            else {echo '<option value="', NULL, '">NULL</option>';}
                            foreach ($res_other as $other) {
                                if ($r->task_code_prev == $other->task_code){echo '<option value="', $other->task_code, '" selected="selected">', $other->task_code, '</option>';}
                                else {echo '<option value="', $other->task_code, '">', $other->task_code, '</option>';}
                            }
                            echo '</select>';
                            echo '</div>';
                            echo '</div>';

                            
                            echo '<div class="md-form mb-5 row">';
                            echo '<label for="minutes_duration" class="col-sm-3 col-form-label">Max doba</label>';
                            echo '<div class="col-sm-9">';
                            echo '<input name="minutes_duration" type="text" id="minutes_duration" class="form-control validate" value="', $r->minutes_duration, '">';
                            echo '</div>';
                            echo '</form>';
                            echo '</div>';
                        }
                }
            }
    }

    public function add_modalAction(){
        $this->view->disable();
        $request =$this->request;
        if ($request->isGet()==true) {
                if ($request->isAjax() == true) {
                        
                        $query_scripts = new Query(
                            'SELECT Scripts.id_script, Scripts.script_name FROM Scripts WHERE 1',
                            $this->di
                        );
                        $res_scripts = $query_scripts->execute();

                        echo '<form>';
                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="task_code" class="col-sm-3 col-form-label">Název úlohy</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="task_code" type="text" id="task_code" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="description" class="col-sm-3 col-form-label">Popis</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="description" type="text" id="description" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';
                        
                        
                        
                        echo '<div class="input-group mb-5  row">';
                        echo '<label for="priority" class="col-sm-3 col-form-label">Priorita</label>';
                        echo '<div class="col-sm-9">';
                        echo '<select name="priority" class="custom-select" id="priority">';
                        echo '<option value="1">Nízka</option>';
                        echo '<option value="2">Střední</option>';
                        echo '<option value="3">Vysoká</option>';
                        echo '</select>';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="warn_email_to" class="col-sm-3 col-form-label">Email varování</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="warn_email_to" type="text" id="warn_email_to" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="warn_sms_to" class="col-sm-3 col-form-label">SMS varování</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="warn_sms_to" type="text" id="warn_sms_to" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="input-group mb-5  row">';
                        echo '<label for="exec_script" class="col-sm-3 col-form-label">Script</label>';
                        echo '<div class="col-sm-9">';
                        echo '<select name="exec_script" class="custom-select" id="exec_script">';
                        foreach ($res_scripts as $script) {
                            echo '<option value="', $script->id_script, '">', $script->script_name, '</option>';
                        }
                        echo '</select>';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="input-group mb-5  row">';
                        echo '<label for="task_schedule_type" class="col-sm-3 col-form-label">Zpuštet</label>';
                        echo '<div class="col-sm-9">';
                        echo '<select name="task_schedule_type" class="custom-select" id="task_schedule_type">';
                        echo '<option value="1">Pozastavené</option>';
                        echo '<option value="2">V definovanou dobu</option>';
                        echo '<option value="3">Po úloze</option>';
                        echo '</select>';
                        echo '</div>';
                        echo '</div>';
                        
                        
                        echo '<div class="input-group mb-5  row" id="days">';
                        echo '<label for="days" class="col-sm-3 col-form-label">Dni v týdnu</label>';
                        echo '<div class="col-sm-9">';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '<input name="checkbox_monday" class="form-check-input" type="checkbox" id="checkbox_monday">';
                        echo '<label for="checkbox_monday">Po</label>';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '</div>';
                        echo '<input name="checkbox_tuesday" class="form-check-input" type="checkbox" id="checkbox_tuesday">';
                        echo '<label for="checkbox_tuesday">Út</label>';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '</div>';
                        echo '<input name="checkbox_wednesday" class="form-check-input" type="checkbox" id="checkbox_wednesday">';
                        echo '<label for="checkbox_wednesday">St</label>';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '</div>';
                        echo '<input name="checkbox_thursday" class="form-check-input" type="checkbox" id="checkbox_thursday">';
                        echo '<label for="checkbox_thursday">Čt</label>';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '</div>';
                        echo '<input name="checkbox_friday" class="form-check-input" type="checkbox" id="checkbox_friday">';
                        echo '<label for="checkbox_friday">Pá</label>';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '</div>';
                        echo '<input name="checkbox_saturday" class="form-check-input" type="checkbox" id="checkbox_saturday">';
                        echo '<label for="checkbox_saturday">So</label>';
                        echo '<div class="form-group mb-5 form-check-inline">';
                        echo '</div>';
                        echo '<input name="checkbox_sunday" class="form-check-input" type="checkbox" id="checkbox_sunday">';
                        echo '<label for="checkbox_sunday">Ne</label>';
                        echo '</div>';
                        echo '</div>';
                        echo '</div>';
                        
                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="hours_start" class="col-sm-3 col-form-label">Hodiny</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="hours_start" type="text" id="hours_start" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="minutes_start" class="col-sm-3 col-form-label">Minuty</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="minutes_start" type="text" id="minutes_start" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="input-group mb-5  row">';
                        echo '<label for="task_code_prev" class="col-sm-3 col-form-label">Po úloze</label>';
                        echo '<div class="col-sm-9">';
                        echo '<select name="task_code_prev" class="custom-select" id="task_code_prev">';
                        echo '<option value="', NULL, '">NULL</option>';
                        foreach ($res_scripts as $script) {
                            echo '<option value="', $script->id_script, '">', $script->script_name, '</option>';
                        }
                        echo '</select>';
                        echo '</div>';
                        echo '</div>';

                        
                        echo '<div class="md-form mb-5 row">';
                        echo '<label for="minutes_duration" class="col-sm-3 col-form-label">Max doba</label>';
                        echo '<div class="col-sm-9">';
                        echo '<input name="minutes_duration" type="text" id="minutes_duration" class="form-control validate">';
                        echo '</div>';
                        echo '</div>';
                        echo '</form>';
                }
            }
    }

    public function addAction(){
        $this->view->disable();
        $request =$this->request;
        if ($request->isPost()==true) {
                if ($request->isAjax() == true) {
                    $data = $_POST["data"];
                    parse_str($data, $output);
                    $week_days = '';
                    if (array_key_exists('checkbox_monday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_tuesday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_wednesday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_thursday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_friday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_saturday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_sunday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    $this->modelsManager->executeQuery(
                        'INSERT INTO Tasks VALUES (:task_code:, :description:, :priority:, :warn_email_to:, :warn_sms_to:, :exec_script:, :task_schedule_type:, :week_days:, :task_code_prev:,
                        :hours_start:, :minutes_start:, :minutes_duration:)',
                        [
                            'description' => $output['description'],
                            'priority' => $output['priority'],
                            'warn_email_to' => $output['warn_email_to'],
                            'warn_sms_to' => $output['warn_sms_to'],
                            'exec_script' => $output['exec_script'],
                            'task_schedule_type' => $output['task_schedule_type'],
                            'week_days' => $week_days,
                            'task_code_prev' => $output['task_code_prev'],
                            'hours_start' => $output['hours_start'],
                            'minutes_start' => $output['minutes_start'],
                            'minutes_duration' => $output['minutes_duration'],
                            'task_code' => $output['task_code'],
                        ]
                    );
                }
            }
    }

    public function updateAction(){
        $this->view->disable();
        $request =$this->request;
        if ($request->isPost()==true) {
                if ($request->isAjax() == true) {
                    $data = $_POST["data"];
                    $task_code = $_POST["task_code"];
                    parse_str($data, $output);
                    // TODO ma sa menit aj task_code?????
                    $week_days = '';
                    if (array_key_exists('checkbox_monday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_tuesday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_wednesday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_thursday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_friday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_saturday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    if (array_key_exists('checkbox_sunday', $output)) {$week_days .= '1';}
                    else {$week_days .= '0';}
                    $this->modelsManager->executeQuery(
                        'UPDATE Tasks SET description = :description:, priority = :priority:, warn_email_to = :warn_email_to:, warn_sms_to = :warn_sms_to:,
                        exec_script = :exec_script:, task_schedule_type = :task_schedule_type:, week_days = :week_days:, task_code_prev = :task_code_prev:,hours_start = :hours_start:,
                        minutes_start = :minutes_start:, minutes_duration = :minutes_duration: WHERE task_code = :task_code:',
                        [
                            'description' => $output['description'],
                            'priority' => $output['priority'],
                            'warn_email_to' => $output['warn_email_to'],
                            'warn_sms_to' => $output['warn_sms_to'],
                            'exec_script' => $output['exec_script'],
                            'task_schedule_type' => $output['task_schedule_type'],
                            'week_days' => $week_days,
                            'task_code_prev' => $output['task_code_prev'],
                            'hours_start' => $output['hours_start'],
                            'minutes_start' => $output['minutes_start'],
                            'minutes_duration' => $output['minutes_duration'],
                            'task_code' => $task_code,
                        ]
                    );
                }
            }
    }

    public function deleteAction(){
        $this->view->disable();
        $request =$this->request;
        if ($request->isPost()==true) {
                if ($request->isAjax() == true) {
                    $task_code = $_POST["task_code"];
                    $res = $this->modelsManager->executeQuery('DELETE FROM Tasks WHERE task_code = :task_code:',
                                                        [
                                                            'task_code' => $task_code
                                                        ]);
                }
            }
    }
}
