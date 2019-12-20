<?php

class TaskLog extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id_task_log;

    /**
     *
     * @var string
     */
    public $task_code;

    /**
     *
     * @var string
     */
    public $dt_created;

    /**
     *
     * @var string
     */
    public $dt_finished;

    /**
     *
     * @var integer
     */
    public $st_code;

    /**
     *
     * @var string
     */
    public $st_message;

    /**
     *
     * @var integer
     */
    public $warn_sent;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("okczwatch");
        $this->setSource("task_log");
        $this->hasMany('id_task_log', 'LogItem', 'id_task_log', ['alias' => 'LogItem']);
        $this->belongsTo('task_code', 'Tasks', 'task_code', ['alias' => 'Tasks']);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'task_log';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return TaskLog[]|TaskLog|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return TaskLog|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
