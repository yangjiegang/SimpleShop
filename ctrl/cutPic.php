<?php
session_start();
require_once(dirname(__FILE__)."/model/models.php");
header("Content-type: text/html; charset=utf-8");
function PIPHP_ImageCrop($image, $x, $y, $w, $h){
 $tw = imagesx($image);
 $th = imagesy($image);
 
 if ($x > $tw || $y > $th || $w > $tw || $h > $th)
  return FALSE;

$temp = imagecreatetruecolor($w, $h);
imagecopyresampled($temp, $image, 0, 0, $x, $y,
  $w, $h, $w, $h);
return $temp;
}

$pic = $_POST['name'];
$cutPosition = json_decode($_POST['position']);  //取得上传的数据
$x1 = $cutPosition->x1;
$y1 = $cutPosition->y1;
$width = $cutPosition->width;
$height = $cutPosition->height;

$type=exif_imagetype($pic);  //判断文件类型
$support_type=array(IMAGETYPE_JPEG , IMAGETYPE_PNG , IMAGETYPE_GIF);
if(!in_array($type, $support_type,true)) {
  echo "this type of image does not support! only support jpg , gif or png";
  exit();
}
switch($type) {
  case IMAGETYPE_JPEG :
  $image = imagecreatefromjpeg($pic);
  break;
  case IMAGETYPE_PNG :
  $image = imagecreatefrompng($pic);
  break;
  case IMAGETYPE_GIF :
  $image = imagecreatefromgif($pic);
  break;
  default:
  echo "Load image error!";
  exit();
}

$copy = PIPHP_ImageCrop($image, $x1, $y1, $width, $height);//裁剪
$name = explode("/", $_POST['name']);
$targetPic = 'upload/cut/'.$name[1];

$model = new Model();
$cid = $_SESSION['uid']; 
$effects = $model->edit("UPDATE `profile` SET uImg='$targetPic' WHERE uid='$cid'");
if ($effects>0) {
  imagejpeg($copy, $targetPic);  //输出新图
  //@unlink($pic);//删除原图节省空间 
  //echo $_POST['pic'].'?'.time(); //返回新图地址
  echo $targetPic;
} else {
  echo "db error";
}

?>