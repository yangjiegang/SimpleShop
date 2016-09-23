<?php
session_start();
if(!$_SESSION['username']){
    //header('location:login.php');
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>admin</title>
    <link rel="stylesheet" href="../easyui/themes/default/easyui.css">
    <link rel="stylesheet" href="../easyui/themes/icon.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>
    <body class="easyui-layout">   
        <div data-options="region:'north',split:true, noheader:true" style="height:60px; background:#666">
            <div class="logo">Admin</div>
            <div class="logout">Welcome: <?php echo ($_SESSION['username']) ?> | <a href="logout.php">Logout</a></div>    
        </div>   
        <div data-options="region:'south',split:true, noheader:true" style="height:35px; line-height:30px; text-align:center;">
            <p>@2009-2016 MyAdmin All rights reserved | Powered By EasyUI</p>
        </div>   
        <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true" style="width:100px;"></div>   
        <div data-options="region:'west',title:'Navigate',split:true" style="width:180px; padding:10px;">
            <ul id="nav"></ul>
        </div>   
        <div data-options="region:'center'" style="padding:5px;background:#eee;overflow:hidden;">
            <div id="tabs">
                <div title="home" style="padding:0 10px; display:block;" data-options="iconCls:'icon-help'">
                    <p>Welcome to admin page.</p>
                </div>
            </div>
        </div>   
    </body>
    <script src="../js/jquery-1.9.1.js"></script>
    <script src="../easyui/jquery.easyui.min.js"></script>
    <!--<script src="../easyui/easyloader.js"></script>-->
    <script src="../js/admin.js"></script>
</body>
</html>