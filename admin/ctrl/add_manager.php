<?php
    require_once("DBconfig.php");
    define('ALL_ps',"test100");
    $username = $_POST['username'];
    $password = md5($_POST['password'].ALL_ps);
    $auth = $_POST['auth'];
    // $lastLoginTime = date("Y-m-d H-i-s");
    // $lastLoginTime = '2016-09-10';
    mysql_query("insert into auth(username,password,auth) values('$username', '$password', '$auth')");
    echo mysql_affected_rows();
    mysql_close();
?>