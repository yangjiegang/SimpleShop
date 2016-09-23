<?php
    require_once("DBconfig.php");

    $gname = $_POST['gname'];
    $price = intval( $_POST['price'] );
    $stock = intval( $_POST['stock'] );
    $gdesc = $_POST['gdesc'];
    // $lastLoginTime = date("Y-m-d H-i-s");
    // $lastLoginTime = '2016-09-10';
    mysql_query("insert into goods(gname,price,stock,gdesc) values('$gname', $price, $stock, '$gdesc')");
    echo mysql_affected_rows();
    mysql_close();
?>