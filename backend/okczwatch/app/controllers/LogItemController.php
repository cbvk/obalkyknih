<?php

class LogItemController extends ControllerBase
{

    public function indexAction()
    {
        $this->view->debug = $_GET['task_log'];
        $this->view->task_code = NULL;
        $request =$this->request;
        if (array_key_exists('task_log', $_GET)){
            $task_log = $_GET['task_log'];
            $this->view->task_log = $task_log;
            $res = $this->modelsManager->executeQuery('SELECT * FROM TaskLog WHERE id_task_log = :task_log:',
            [
                'task_log' => $task_log
            ]);
            $log = $res->getFirst();
            $this->view->task_code = $log->task_code;
            $this->view->dt_created = $log->dt_created;
            // $this->view->task_code = $res;
            // $this->view->task_log = $task_log;
            $res = $this->modelsManager->executeQuery('SELECT * FROM LogItem WHERE id_task_log = :task_log:',
                                                        [
                                                            'task_log' => $task_log
                                                        ]);
            $this->view->logitems = $res;                                      
        }
        
    }

}

