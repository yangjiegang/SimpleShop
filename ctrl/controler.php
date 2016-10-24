<?php 
error_reporting(E_ALL ^ E_NOTICE);
header("Content-type: text/html; charset=utf-8");
require_once(dirname(__FILE__).'/../util/tools.php');
require_once(ROOT.'/util/userIntercept.php');
require_once(ROOT.'/model/models.php');
require_once(ROOT.'/util/jsonTool.php');

$cid = $_SESSION["uid"];
$model = new Model();
$userIntercept = new UserIntercept();

if(!empty($_GET['action'])){
	// if($_GET['action']=='payAllNow'){
	// 	$sum = floatval( $_GET['sum'] );
	// 	$arr = $model->find("select balance from profile where uid=$cid limit 1");
	// 	print_r($arr);
	// 	$balance = floatval($arr[0]['balance']);
	// 	if ($balance<$sum){
	// 		echo ('less');
	// 	} else if($balance>=$sum) {
	// 		$remain = $balance-$sum;
	// 		$effects = $model->edit("update profile set balance=$remain where uid=$cid");    
	// 		if($effects>0){
	// 			echo('success');
	// 		}
	// 	} else {
	// 		echo('pay error!');
	// 	}
	// }

	if($_GET['action']=='account'){
		$arrOrders = $model->find("select o.id,o.ctime,o.gid,o.count,g.gname,g.price,g.gdesc,g.gimg from orders o,goods g where o.gid=g.id and o.cid=$cid");
		$arrProfile = $model->find("select nick,gender,balance,degree,motto from profile where uid=$cid limit 1");
		$jsonStr01 = array2json($arrOrders);
		$jsonStr02 = array2json($arrProfile);
		$jsonStr = '['.$jsonStr01.','.$jsonStr02.']';
		// $arr = array_merge($arrOrders, $arrProfile);
		// $arr = array("orders"=>$arrOrders, "profile"=>$arrProfile);
		// $arr = array($arrOrders, $arrProfile);
		// $jsonStr = json_encode($arr);
		// print_r($jsonStr02);
		echo $jsonStr;
	}

	if($_GET['action']=='debug'){
		var_dump($cid, $_SESSION['unm']);
	}
}

if(isset($_POST['action'])){
	switch($_POST["action"]){
		case "account":
			$arrOrders = $model->find("select o.id,o.ctime,o.gid,o.count,g.gname,g.price,g.gdesc,g.gimg from orders o,goods g where o.gid=g.id and o.cid=$cid");
			$arrProfile = $model->find("select uImg,nick,gender,balance,level,motto from profile where uid=$cid");
			$arrComments = $model->find("select oid,content,degree,ctime from comment where cid=$cid");
			$arr = array("orders"=>$arrOrders, "profiles"=>$arrProfile, 'comments'=>$arrComments);
			$jsonStr = json_encode($arr);
			echo $jsonStr;
			break;

		case 'single':
			$gid=$_POST['gid'];
			$arrGoods = $model->find("select id,sid,gname,gdesc,price,stock,gimg from goods where id=$gid");
			$arrComments = $model->find("select p.nick,c.degree,c.content,c.ctime from comment c,profile p,orders o where c.cid=p.uid and c.oid=o.id and o.gid=$gid");
			$arr = array('goods'=>$arrGoods, 'comments'=>$arrComments);
			$jsonStr = json_encode($arr);
			echo $jsonStr;
			break;

		case 'searchGoods':
			$search=$_POST['search'];
			$arr = $model->find("select p.nick as vendor,g.gname,g.gdesc,g.price,g.stock,g.gimg from goods g,profile p where g.sid=p.uid and g.gname like '%$search%'");
			// var_dump($arr);
			echo json_encode($arr);
			break;

		case 'checkout':
			$arr1 = $model->find("select c.gid,c.count,g.gname,g.price,g.gdesc,g.stock,g.gimg from cart c,goods g where c.gid=g.id and c.cid=$cid");
			// $arr2=[];
			// for ($i=0; $i < count($arr1); $i++) { 
			// 	$gid = $arr1[$i]['gid'];
			// 	$goodsRows = mysql_query("select sid,gname,gdesc,price,gimg from goods where sid=$gid limit 1");
			// 	array_push($arr2, mysql_fetch_row($goodsRows));
			// }
			// $jsonStr = json_encode($arr2);
			$jsonStr = array2json($arr1);
			echo $jsonStr;
			break;

		case 'putInCart':
		    $gid = $_POST["gid"];
			$count = $_POST['count'];
			$ctime = date("Y-m-d H-m-s");
			$effects01 = $model->edit("update cart set count=(count+$count) where gid=$gid and cid=$cid");
			if($effects01 == 0){
				$effects02 = $model->edit("insert into cart(gid, cid, count, ctime) values('$gid', '$cid', '$count', '$ctime')");
				echo $effects02;
			} else {
				echo $effects01;
			}
			break;

		case 'buyItNow':
			$gid = $_POST["gid"];
			$count = $_POST['count'];
			$ctime = date("Y-m-d H-m-s");
			$query01 = $model->edit("update cart set count=(count+$count) where gid=$gid and cid=$cid");
			if($query01==0){
				$qrIst = $model->edit("insert into cart(gid, cid, count, ctime) values('$gid', '$cid', '$count', '$ctime')");
				if($qrIst > 0){
					@header("location:../checkout.html");
				}else{
					echo 'db insert error';
				}
			}else if($query01 > 0){
				@header("location:../checkout.html");
			}else{
				echo 'db update error';
			}
			break;

		case 'payAllNow':
			$sum = floatval( $_POST['sum'] );
			$arr = $model->find("select balance from profile where uid=$cid limit 1");
			$balance = floatval($arr[0]['balance']);
			if ($balance < $sum){
				echo ('less');
			} else if($balance>=$sum) {
				$remain = $balance-$sum;
				$effects = $model->edit("update profile set balance=$remain where uid=$cid");    
				if($effects>0){
					echo('success');
				}
			} else {
				echo('pay error!');
			}
			break;

			case "login":
				$username = $_POST['username'];
				$password = md5($_POST['password'].ALL_ps);
				$shell=md5($username.$password);
				$us=is_array($row = $model->find("select id,username,password,level from auth where username='$username' limit 1"));
				$flag = $us ? $shell==md5($row[0]['username'].$row[0]['password']):FALSE;

				if(true){
					$_SESSION['unm']=$username;
					$_SESSION['uid']=$row[0]['id'];
					$_SESSION['user_shell']=$shell;
					$_SESSION['times']=time();
					header("location:../account.html");
				}else{
					echo "用户名或密码错误";
					session_unset();
					session_destroy();//密码错误时消除所有的session
				}
				break;

			case 'comment':
				$stars = $_POST['stars'];
				$content = $_POST['content'];
				$ctime = date('Y-m-d H-m-s');
				$oid = $_POST['oid'];
				$effects = $model->edit("insert into comment(oid, cid, content, degree, ctime) values($oid, $cid, '$content', $stars, '$ctime')");
				header("location:../account.html");
				break;

			case 'state':
				echo $userIntercept->isLogin();
				break;

			case "register":
				// header("location:../register.php");
				$username=$_POST['username'];
				$password=md5($_POST['password'].ALL_ps);
				$nick=$_POST['nick'];
				$age=$_POST['age'];
				$gender=$_POST['gender'];
				$ctime = data('Y-m-d H-m-s');
				$model->edit("insert into auth(username, password) values('$username', '$password')");
				$uid = intval( $model->find("select id from auth where username='$username'") );
				$model->edit("insert into profile(uid, nick, age, gender, level, ctime) values($uid, '$nick', $age, $gender, 2, $ctime)");
				header("location:../login.html");
				break;
				
			case "logout":
				echo "你已经成功退出登录!";
				session_unset();
				session_destroy();
				break;

			default:
				break;		
	}//switch block
}

?>