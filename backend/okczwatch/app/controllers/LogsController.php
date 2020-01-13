<?php


class LogsController extends ControllerBase
{

    public function indexAction()
    {
        $this->view->debug = $_GET['task_code'];
        $this->view->task_code = NULL;
        if (array_key_exists('task_code', $_GET)){
            $task_code = $_GET['task_code'];
            $this->view->task_code = $task_code;
            $res = $this->modelsManager->executeQuery('SELECT * FROM TaskLog WHERE task_code = :task_code:',
                                                        [
                                                            'task_code' => $task_code
                                                        ]);
            $this->view->logs = $res;                                           
        }
        else {$this->view->logs = TaskLog::find();}
    }

}

