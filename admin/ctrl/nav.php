<?php
    require_once("DBconfig.php");
    // require_once("loginIntercept.php");
    $id = isset($_POST['id']) ? $_POST['id'] : 0;
    $res = mysql_query("SELECT id,text,state,url,iconCls FROM navbar WHERE nid = '$id'");
    $jsonStr='';
    while (!! $row = mysql_fetch_array($res, MYSQL_ASSOC)){
        $jsonStr .= json_encode($row).',';
    }
    $jsonStr = substr($jsonStr, 0 ,-1);
    echo ('['.$jsonStr.']');
    mysql_close();
?>