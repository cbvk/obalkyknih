<?php

class cachex_alive_copy
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
