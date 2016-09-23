<?php
    require_once("DBconfig.php");

    $id = $_POST['id'];

    $res = mysql_query("select * from auth where id='$id'");
    $jsonStr = '';
    while (!!$rows = mysql_fetch_array($res, MYSQL_ASSOC)){
        $jsonStr .= json_encode($rows).',';
    }
    $jsonStr = substr($jsonStr, 0, -1);
    echo('['.$jsonStr.']');
    mysql_close();
?>