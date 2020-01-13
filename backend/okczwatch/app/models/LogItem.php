<?php

class LogItem extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id_log_item;

    /**
     *
     * @var integer
     */
    public $id_task_log;

    /**
     *
     * @var string
     */
    public $log;

    /**
     *
     * @var string
     */
    public $dt_created;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->setSchema("okczwatch");
        $this->setSource("log_item");
        $this->belongsTo('id_task_log', 'TaskLog', 'id_task_log', ['alias' => 'TaskLog']);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'log_item';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return LogItem[]|LogItem|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return LogItem|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
