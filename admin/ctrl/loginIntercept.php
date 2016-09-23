<?php
    if (!$_SESSION['username']){
        header('location:../view/login.php');
    }
?>