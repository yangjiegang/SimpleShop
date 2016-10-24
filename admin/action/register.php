<html>
<head>
<meta charset="utf-8">
<title>注册新用户</title>
</head>
<body alink="#FF0000" link="#000099" vlink="#CC6600" topmargin="8" leftmargin="0" bgColor="#FFFFFF">
<br>
<?php
	include_once("login_config.php");
	//echo $_SERVER['PHP_SELF'];
	if(!empty($_POST["username"]) && !empty($_POST["password"])){
		$unm = $_POST["username"];
		$pwd = $_POST["password"];
		$pwd_safe = md5($pwd.ALL_ps);
		if($unm!=""){
			//$ID = uniqid("userID");
			//$db = mysql_connect("localhost","root","");
			//mysql_select_db (DBNEWS, $conn);
			$result = mysql_query ("insert into user_list (m_id, username, password) VALUES (2,'$unm','$pwd_safe')");
			if(!$result){
				echo "<center>出现错误：</center>", mysql_error();
				exit;
			}
			if($result){
				//mysql_close($conn);
				//exit();
				echo "<center>用户 <b>$unm</b> 注册成功！</center>\n <center><a href='login.html'>立刻登录</a></center>\n";
			}
		}else{
			echo "<center>资料填写不完整，请仔细填写！</center>";
		}
	}
?>
<form method="post" action="<?php echo $_SERVER['PHP_SELF'] ?>">
<table cellspacing=0 bordercolordark=#FFFFFF width="60%" bordercolorlight=#000000 border=1 align="center" cellpadding="2">
  <tr bgcolor="#6b8ba8" style="color:FFFFFF">
    <td width="100%" align="center" valign="bottom" height="19">注册新用户</td>
  </tr>
  <tr>
    <td width="100%" align="center">
姓名：<INPUT TYPE=text MAXLENGTH=20 NAME="username" SIZE=20><Br>
呢称：<INPUT TYPE=text MAXLENGTH=20 NAME="userid" SIZE=20><Br>
密码：<Input Type=text Maxlength=20 Name="password" Size=20><Br>
邮件：<Input Type=text Maxlength=50 Name="email" Size=20><Br>
<INPUT TYPE=submit VALUE="注 册">
<INPUT type=reset VALUE="重 填">
    </td>
  </tr>
</table>
</form>
<!-- <?
	}
?> -->
</body>
</html>