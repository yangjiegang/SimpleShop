<?php
header("Content-type: text/html; charset=utf-8"); 
    require_once("dbconfig.php");
    // require_once("login_config.php");
    // require_once("models.php");

if($_POST["gid"]){

    $gid=$_POST['gid'];

    $res = mysql_query("select id,sid,gname,gdesc,price,stock,gimg from goods where id=$gid");
    // $res = mysql_query("select gdetails from goods where id=2");
    $jsonStr = '';
    while (!!$rows = mysql_fetch_array($res, MYSQL_ASSOC)){
        // var_dump($rows);
        $jsonStr .= json_encode($rows).',';
    }
    $jsonStr = substr($jsonStr, 0, -1);
    echo('['.$jsonStr.']');
    mysql_close();
}

?>