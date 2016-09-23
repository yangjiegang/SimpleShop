<?PHP 
    require_once("DBconfig.php");

    $ids = $_POST['ids'];

    mysql_query("delete from goods where id in ($ids)");

    echo mysql_affected_rows();
    mysql_close();
?>