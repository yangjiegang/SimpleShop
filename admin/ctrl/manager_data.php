<?php
    require_once("DBconfig.php");
    // require_once("loginIntercept.php");
    $page = $_POST['page'];
    $pageSize = $_POST['rows'];
    $first = $pageSize * ($page-1);
    $order = $_POST['order'];
    $sort = $_POST['sort'];
    $res = mysql_query("SELECT id,username,auth FROM auth ORDER BY $sort $order LIMIT $first,$pageSize");// or die('SQL fault');
    $total = mysql_num_rows( mysql_query("SELECT id,username,auth FROM auth"));
    $jsonStr='';
    while (!! $row = mysql_fetch_array($res, MYSQL_ASSOC)){
        $jsonStr .= json_encode($row).',';
    }
    $jsonStr = substr($jsonStr, 0 ,-1);
    // echo ('['.$jsonStr.']');
    echo ('{"total":'.$total.',"rows":['.$jsonStr.']}');
    mysql_close();
?>