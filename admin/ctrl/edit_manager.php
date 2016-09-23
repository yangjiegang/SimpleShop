<?php
    require_once("DBconfig.php");
    define('ALL_ps',"test100");
    $id = $_POST['id'];
    $password =  md5($_POST['password_edit'].ALL_ps);
    $auth =$_POST['auth_edit'];
    // if ( !empty($_POST['password_edit']) ){

    // }
    mysql_query("update auth set password='$password',auth='$auth' where id='$id'");
    echo mysql_affected_rows();
    mysql_close();
?>