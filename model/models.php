<?php
require_once(dirname(__FILE__).'/../util/tools.php');
require_once(ROOT.'/util/dbconfig.php');

class Model{
	public function find($sql){
		$res = mysql_query($sql);
		if($res!=null && $res!=false){
			$arr = array();
			while(!!$row = mysql_fetch_array($res)){
				array_push($arr, $row);
			}
			// mysql_close($conn);
			return $arr;			
		} else {
			return null;
		}
	}
	public function edit($sql){
		$res = mysql_query($sql);
		return $res;
		// return mysql_affected_rows;
		// mysql_close($conn);
	}
}

?>