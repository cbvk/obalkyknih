<?php

class IndexController extends ControllerBase
{

    /**
     * Zoznam uloh
     */
    public function indexAction()
    {
        $this->view->tasks = Tasks::find();
    }

}

