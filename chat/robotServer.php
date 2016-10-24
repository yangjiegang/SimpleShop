<?php
header('Content-type:text/html; charset=utf-8');
// error_reporting(E_ERROR);
error_reporting(0);
require ('pscws23/pscws3.class.php');
require_once('dbconfig.php');
// require('pscws23/pscws2.class.php');
// require('pscws23/xdb_r.class.php');

if (isset($_GET['message']) && $_GET['message']!="") {
    $message=trim( $_GET['message'] );
    $robot = new robotChat($message, $conn);
    $res = $robot->response()[1];
    // $res = utf8_encode($robot->response()[1]);
    // echo( json_encode($robot->response()[1]) );
    echo $_GET['jsoncallback'].'('.json_encode($res).')';
}

class robotChat{
    protected $str;
    protected $conn;

    function __construct($str, $conn){
        $this->str=$str;
        $this->conn=$conn;
    }

    public function response(){
        @$arr = $this->divWords($this->str);
        return $this->getBest($arr, $this->conn);
    }

    public function divWords($str){
        $pscws = new PSCWS3('pscws23/dict/dict.xdb');
        $pscws->set_debug(false);
        $res = $pscws->segment($str);
        // print_r($res);
        $len=count($res);
        $ar01=array();
        // $i=0;$j=0;
        for($i=0;$i<$len;$i++){
            array_push($ar01, $res[$i]);
        }
        $ar02=array();
        for($i=0;$i<$len;$i++){
            for($j=$len-1; $j>$i; $j--){
                array_push($ar02, $res[$i].$res[$j]);
            }
        }
        $ar03=array();
        for($i=0;$i<$len;$i++){
            for($j=$i+1; $j<$len; $j++){
                for ($k=$j+1; $k < $len; $k++) { 
                    array_push($ar03, $res[$i].$res[$j].$res[$k]);
                }
            }
        }
        $ar04=array_merge($ar01,$ar02,$ar03);
        return $ar04;
    }

    public function find($sql,$link){
        $ar05=array();
        // foreach($arr as $question){
            // $sql= "select answer from ChatDict where question like '{$question}%'";
            $back = mysql_query($sql, $link);
            while($row = mysql_fetch_array($back)){
                // echo "00,";
                array_push($ar05,$row['question']);
                array_push($ar05,$row['answer']);
            }
        // }
        return $ar05;
    }

    public function getBest($arr, $conn) {
        $len = count($arr);
        for($i=0; $i<$len; $i++){
            $sql01= "select question,answer from ChatDict where question like '{$arr[$i]}%'";
            if(count($this->find($sql01,$conn))==0){
                continue;
            } elseif ($i==$len-1) {
                // echo($i);
                break;
            } else {
                return $this->find($sql01,$conn);
            }
        }
        for ($i=0; $i < $len; $i++) { 
            $sql02= "select question,answer from ChatDict where question like '%{$arr[$i]}'";
            if(count($this->find($sql02,$conn))==0){
                continue;
            } elseif($i==$len-1){
                break;
            } else {
                return $this->find($sql02,$conn);
            }
        }
        for ($i=0; $i < $len; $i++) {
            $sql03 = "select question,answer from ChatDict where question like '%{$arr[$i]}%'";
            if (count($this->find($sql02,$conn))==0) {
                continue;
            } elseif($i==$len-1){
                break;
            } else {                
                return $this->find($sql03,$conn);
            }
        }
    }

}

// $rbt = new robotChat("我问你是谁啊",$conn);
// print_r( $rbt->response() );
// var_dump( $rbt->response() );
?>