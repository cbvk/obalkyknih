<?php

define('DEBUG', getenv('DEBUG')=='1');

// Loguje ak je nastaveny system env DEBUG=1
// v bash "export DEBUG=1"
function _log($str) {
    if (DEBUG) echo $str . "\n";
}
