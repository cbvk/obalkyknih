<?php

class cachex_alive
{

    static function main ($db)
    {
        $sql = 'SELECT * FROM tasks';
        $res = $db->query($sql);

        while ($row = $res->fetch()) {

        }

        return array( OK, '' );
    }

}
