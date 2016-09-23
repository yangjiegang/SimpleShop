<?php
require_once("dbconfig.php");
require_once("login_config.php");
require_once("models.php");

$cid = $_SESSION["uid"];

if(isset($_POST['checkout'])){//from checkout.html
    // $qrOt = mysql_query("select * from cart where cid='$cid'");
    // $arr = [];
    // $rows = mysql_fetch_array($qrOt);
    // for ($i=0; $i < count($rows); $i++) {
    //     var_dump($rows[$i]);
    //     array_push($arr, $rows[$i]['gid']);
    // }

    $qrOt = mysql_query("select gid from cart where cid=$cid");
    $arr1 = [];
    while(!!$rows = mysql_fetch_array($qrOt)){
        array_push($arr1, $rows);
    };
    $arr2=[];
    for ($i=0; $i < count($arr1); $i++) { 
        $gid = $arr1[$i]['gid'];
        $goodsRows = mysql_query("select sid,gname,gdesc,price,gimg from goods where sid=$gid limit 1");
        array_push($arr2, mysql_fetch_row($goodsRows));
    }
    $jsonStr = json_encode($arr2);
    echo $jsonStr;

} else if(isset($_POST['cart'])) {//put in cart
    $gid = $_POST["gid"];
    $count = $_POST['count'];
    $ctime = date("Y-m-d H-m-s");
    $query01 = mysql_query("update cart set count=count+$count where gid=$gid and cid=$cid");
    if($query01==0){
        $qrIst = mysql_query("insert into cart (gid, cid, count, ctime) values('$gid', '$cid', '$count', '$ctime')");
        echo $qrIst;
    } else {
        echo $query01;
    }
} else {//form submit here from single.html
    $gid = $_POST["gid"];
    $count = $_POST['count'];
    $ctime = date("Y-m-d H-m-s");
    $query01 = mysql_query("update cart set count=count+$count where gid=$gid and cid=$cid");
    if($query01==0){
        $qrIst = mysql_query("insert into cart (gid, cid, count, ctime) values('$gid', '$cid', '$count', '$ctime')");
        if($qrIst>0){
            @header("location:checkout.html");
        }
    }
    if($query01 > 0){
        @header("location:checkout.html");
    }

    // echo($qrIst);
}
?>