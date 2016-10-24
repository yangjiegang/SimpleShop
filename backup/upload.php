<?php
header("Content-type: text/html; charset=utf-8");
/*$backValue=array("name"=>"","description"=>"","img"=>"");
if(!empty($_POST["data"])){
	$name = $_POST["data"]["name"];
	$description = $_POST["data"]["description"];
	$backValue["name"]=$name;
	$backValue["description"]=$description;
	echo($name, $description);
	var_dump($_POST["data"]);
}*/
if(($_FILES["fileToUpload"]["type"]=="image/jpeg" || $_FILES["fileToUpload"]["type"]=="image/jpg" || $_FILES["fileToUpload"]["type"]=="image/gif" || $_FILES["fileToUpload"]["type"]=="image/png")&&$_FILES["fileToUpload"]["size"]<=102400){
	if($_FILES["fileToUpload"]["error"]>0){
		//echo "error".$_FILES["fileToUpload"]["error"];
	}else{
		//echo "Temp file: ".$_FILES["fileToUpload"]["name"]."\n";
		if(file_exists("upload/".$_FILES["fileToUpload"]["name"])){
			//echo "Exists already.";
		}else{
			move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], "upload/".$_FILES["fileToUpload"]["name"]);
			//echo "Stored successfully!\n";
			//echo "upload/".$_FILES["fileToUpload"]["name"];
			//$backValue["img"]="upload\\".$_FILES["fileToUpload"]["name"];
			$file = "upload/".$_FILES["fileToUpload"]["name"];
		}
	}
}else{
	//echo "Invalid type of file.";
}
//$filename = "upload".DIRECTORY_SEPARATOR."temp_php3.gif";
$filename = "upload/temp_php3.gif";
$imgSize = getimagesize($filename);
//$picFormat = array()
$data = array('img' => $filename, 'height'=>$imgSize[1], 'width'=>$imgSize[0],);
//echo $data;
echo json_encode($data);
//echo $img;
?>