<?php
// error_reporting(E_ALL ^ E_DEPRECATED);
error_reporting(0);

define('HOST',"localhost");//主机名
define('USER',"root");//用户名
define('PASS',"");//密码
define('DBNAME',"test");//数据库名
$conn = mysql_connect(HOST,USER,PASS);
mysql_set_charset('utf8', $conn); 
mysql_select_db(DBNAME,$conn);
?>