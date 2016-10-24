<?php
header("Content-type: text/html; charset=utf-8");
session_start();
error_reporting(E_ALL ^ E_DEPRECATED);
require_once('../util/tools.php');
require_once('dbconfig.php');
require_once("../model/models.php");
// define('ALL_ps',"test100");
$model = new Model();

class UserIntercept{
    //查看登录状态与权限
    function user_shell($username,$shell){
        // $sql="select username,password,level from auth where uid='$uid'";
        // $query=mysql_query($sql);
        // $us=is_array($row=mysql_fetch_array($query));
        $us=is_array($model->find("select username,password,level from auth where username='$username'"));
        return $us ? $shell==md5($row['username'].$row['password'].ALL_ps):FALSE;
        // if($flag){
        //     if($row['level']<=$level){//$row[m_id]越小权限越高，为1时权限最高
        //         return $row;
        //     }else{
        //         echo "你的权限不足,不能查看该页面";
        //         header('location:/PEMarket/index.html');
        //         exit();
        //     }
        // }else{
        //     echo "登录后才能查看该页";
        //     header('location:/PEMarket/login.html');
        //     exit();
        // }
    }
    //设置登录超时
    function user_mktime($onlinetime){
        $new_time=time();//mktime()->time()
        echo $new_time-$onlinetime."秒未操作该页面"."<br>";
        if($new_time-$onlinetime>'10'){//设置超时时间为10秒，测试用
            echo "登录超时,请重新登录";
            exit();
            session_unset();
            session_destroy();
        }else{
            $_SESSION['times']=time();//mktime()->time()
        }
    }
    
    function isLogin(){
        $model = new Model();
        if ( !empty($_SESSION['unm']) && isset( $_SESSION['user_shell'] ) ){
            $unm = $_SESSION['unm'];
            $arr = $model->find("select username, password from auth where username='$unm'");
            // var_dump($arr);
            // echo('<br/>');
            // var_dump( $_SESSION['user_shell'] );
            // echo('<br/>');
            // var_dump( md5($arr[0]['username'].$arr[0]['password']) );
            // echo('<br/>');
            // var_dump( $_SESSION['user_shell']==md5($arr[0]['username'].$arr[0]['password']));
            // echo('<br/>');
            if( $_SESSION['user_shell']==md5($arr[0]['username'].$arr[0]['password']) ){
                return $unm;
            }
        }
        return 'FALSE';
    }
}

$u = new UserIntercept();
$u->isLogin();

?>