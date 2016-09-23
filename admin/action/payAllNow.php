<?php
require_once("dbconfig.php");
require_once("login_config.php");
require_once("models.php");

$cid = $_SESSION["uid"];

if(isset($_POST['payAllNow'])){
    $sum = floatval( $_POST['sum'] );
    $query = mysql_query("select balance from profile where id=1 limit 1");
    $rows = mysql_fetch_array($query);
    // var_dump($rows);
    $balance = floatval($rows[0]);
    // var_dump($balance);
    if ($balance<$sum){
        echo ('your balance is not enougn!');
    } else if($balance>=$sum){
        $remain = $balance-$sum;
        // $effects = mysql_query("update profile set balance=($balance-$sum) where id=$cid"); 
        $effects = mysql_query("update profile set balance=$remain where id=$cid");    
        if($effects>0){
            // @header("location:account.html");
            echo('success');
        }
    }

} else {
    // $gid = $_POST["gid"];
    // $ctime = date("Y-m-d H-m-s");
    // $qrIst = mysql_query("insert into cart (gid, cid, ctime) values('$gid', '$cid', '$ctime')");
    // @header("location:checkout.html");
}

?>