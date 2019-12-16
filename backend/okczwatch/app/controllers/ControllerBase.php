<?php

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Url;

class ControllerBase extends Controller
{
    public function indexAction()
    {
        $this->url = new Url();
    }
}
