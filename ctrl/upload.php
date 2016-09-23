<?php
session_start();
header("Content-type: text/html; charset=utf-8");
require_once(dirname(__FILE__)."/model/models.php");

// echo "string".DIRECTORY_SEPARATOR."end";

if ( isset($_FILES["fileToUpload"]) ) {
	if(($_FILES["fileToUpload"]["type"]=="image/jpeg" || $_FILES["fileToUpload"]["type"]=="image/jpg" || $_FILES["fileToUpload"]["type"]=="image/gif" || $_FILES["fileToUpload"]["type"]=="image/png")&&$_FILES["fileToUpload"]["size"]<=9999999999999999){
		if($_FILES["fileToUpload"]["error"]>0){
			var_dump($_FILES["fileToUpload"]["name"]);
			var_dump($_FILES["fileToUpload"]["type"]);
			echo "error".$_FILES["fileToUpload"]["error"];
		}else{
			// echo "Temp file: ".$_FILES["fileToUpload"]["name"]."\n";
			if(file_exists("upload/".$_FILES["fileToUpload"]["name"])){
				echo "Exists already.";
			}else{
				move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], "upload/".$_FILES["fileToUpload"]["name"]);
				// echo "Stored successfully!\n";
				//echo "upload/".$_FILES["fileToUpload"]["name"];
				//$backValue["img"]="upload\\".$_FILES["fileToUpload"]["name"];
				$filename = "upload/".$_FILES["fileToUpload"]["name"];
				$model = new Model();
				$cid = $_SESSION['uid'];
				$effects = $model->edit("UPDATE `profile` SET uImg='$filename' WHERE uid='$cid'");
				if ($effects>0) {
					$imgSize = getimagesize($filename);
					$data = array('img' => $filename, 'height'=>$imgSize[1], 'width'=>$imgSize[0]);
					echo json_encode($data);
				} else {
					echo "db error";
				}
			}
		}
	}else{
		echo "Invalid type of file.";
	}
}

?>