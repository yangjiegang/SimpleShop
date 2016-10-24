<?php
    function array2json($arr){
        $jsonStr = '';
        for ($i=0; $i < count($arr); $i++) { 
            $jsonStr .= json_encode($arr[$i]).',';
        }
        $jsonStr = substr($jsonStr, 0, -1);
        return '['.$jsonStr.']';
    }
?>