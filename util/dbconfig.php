<?php
error_reporting(E_ALL ^ E_DEPRECATED);

//数据库连接
define('HOST',"localhost");//主机名
define('USER',"root");//用户名
define('PASS',"");//密码
define('DBNAME',"simpleshop");//数据库名
$conn = mysql_connect(HOST,USER,PASS);
mysql_set_charset('utf-8');
// mysqli_set_charset ( $conn , 'utf-8' );
mysql_select_db(DBNAME, $conn);
?>