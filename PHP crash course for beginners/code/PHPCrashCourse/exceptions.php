<?php
    echo "Exceptions in PHP";
    function divide($a, $b) {
        if(!$b) {
            throw new Exception("Cannot divide by zero");
        }
        return $a / $b;
    }
    //echo divide(5, 0);
    try {
        echo divide(10, 2);
        //echo divide(5, 0);
        echo "no errors";
    }catch(Exception $e) {
        echo "Caught exception: " . $e->getMessage() . "\n";
    } finally {
        echo "Finally come here...";
    }
    echo "Program runs here..";
?>  