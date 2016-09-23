<?php
    require_once("dbconfig.php");
    require_once("login_config.php");
    require_once("models.php");
    
    $search=$_POST['search'];
    // echo $search;
    // $search = 'iphone';
    $query = mysql_query("select sid,gname,gdesc,price from goods where gname like '%$search%'");
    $arr = [];
    while(!!$rows = mysql_fetch_array($query)){
        array_push($arr, $rows);
    }
    var_dump($arr);
?>