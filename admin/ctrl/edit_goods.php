<?php
    require_once("DBconfig.php");

    $id = $_POST['gid'];
    $gname =  $_POST['gname_edit'];
    $price = $_POST['price_edit'];
    $stock = $_POST['stock_edit'];
    $gdesc = $_POST['gdesc_edit'];
    mysql_query("update goods set gname='$gname', price='$price', stock='$stock', gdesc='$gdesc' where id='$id'");
    echo mysql_affected_rows();
    mysql_close();
?>