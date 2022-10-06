<?php
    /**
     Cookies: - save data in remote browser
     - You can retrieve it when the user visit the site again
     */
    echo "Cookies in PHP<br>";
    //save data to cookie
    setcookie('name', 'Hoang', time() + 24*3600);
    //after 1 day, cookie will be expired 
    //1 month = 24*3600*30
    //check the existing cookie
    if(isset($_COOKIE['name'])) {
        echo $_COOKIE['name'];
    }
    setcookie('name', '', time() - 24*3600); //unset cookie