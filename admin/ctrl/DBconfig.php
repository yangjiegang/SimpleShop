<?php
    header("Content-Type:text/html; charset=utf-8");

    define('DB_HOST', 'localhost');
    define('DB_USER', 'alex');
    define('DB_PASS', '123');
    define('DB_NAME', 'simpleshop');

    $conn = @mysql_connect(DB_HOST, DB_USER, DB_PASS) or die('connect failed!');
    mysql_set_charset('utf-8');
    @mysql_select_db(DB_NAME) or die('select DB failed!');
?>