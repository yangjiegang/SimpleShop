<?php
    header("Content-type: text/html; charset=utf-8");
    session_start();
    require_once('DBconfig.php');
    define('ALL_ps',"test100");
    $username = $_POST['username'];
    // $password = sha1($_POST['password']);
    $password = md5($_POST['password'].ALL_ps);
    // $username = 'admin';
    // $password = '123456';
    $res = mysql_query("SELECT id FROM auth WHERE username='$username' AND password='$password' LIMIT 1");
    if(!!mysql_fetch_array($res, MYSQL_ASSOC)){
        $_SESSION['username'] = $username;
        echo 1;
    } else {
        echo 0;
    }
?>