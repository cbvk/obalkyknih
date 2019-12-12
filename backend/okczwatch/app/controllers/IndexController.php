<?php

use Phalcon\Mvc\Controller;

class IndexController extends Controller
{
    /**
     * Zoznam uloh
     */
    public function indexAction()
    {
        $this->view->tasks = Tasks::find();
    }
}
