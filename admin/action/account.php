<?php
require_once("dbconfig.php");
require_once("login_config.php");
// require_once("models.php");
if(isset($_POST['account'])){

	$cid = $_SESSION["uid"];
	
	$qrOt = mysql_query("select * from orders where cid=$cid limit 1");
	// var_dump($qrOt);
	if($qrOt!=null || $qrOt!=false){
		$jsonStr='';
		while($row = mysql_fetch_array($qrOt)!=-1){;
			$jsonStr .= json_encode($row).',';
		}
		echo $jsonStr;
	}
	
	// $array=[];
	// for ($i=0; $i < $row.length(); $i++) { 
	// 	array_push($array, $row["cid"],$row["gid"],$row["ctime"]);
	// }

}

?>