<?php
    //echo "String functions in PHP";
    $full_name = 'Nguyen Duc Hoang';
    //echo "length: " . strlen($full_name);
    //reverse a string
    //echo strrev($full_name);
    //conert to lowercase
    //echo strtolower($full_name);
    //echo strtoupper($full_name);
    //find and replace
    //echo str_replace(' ', '-', $full_name);
    if(str_starts_with(strtolower($full_name), 'nguyen')) {
        echo "His name starts with nguyen<br>";
    }
    if(str_ends_with(strtolower($full_name), 'hoang')) {
        echo "His name ends with hoang <br>";
    }
    echo "<h1>html string</h1>";    
    //how to ignore the html string ?
    echo htmlspecialchars("<h1>html string</h1>");
    //echo "<script>alert('This is javascript code')</script>";
    echo htmlspecialchars("<script>alert('This is javascript code')</script>");
    //htmlspecialchars used to get data in form
    printf('<br>%s likes %s', 'Hoang', 'Mercedes G63');
    printf('pi = %f', 3.14);
?>