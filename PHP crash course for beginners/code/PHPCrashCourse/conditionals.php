<?php
    // echo "We talk about conditional in PHP<br>";
    $age = 15;
    // if($age >= 18) {
    //     echo "You are greater than or equal to 18 years old";
    // } else {
    //     echo "You are so young";
    // }
    //$hours = date("H");
    $hours = 18;
    //echo $hours;
    // if($hours < 12) {
    //     echo "Good morning";
    // } else if($hours >= 12 && $hours <= 17) {
    //     echo "Good afternoon";
    // } else {
    //     echo "Good evening";
    // }
    $comments = [
        'Good question', 'I like it', 'How are you ?'
    ];
    /*
    if(!empty($comments)) { //not = !
        echo "There are some comments";
    } else {
        echo 'No comments';
    }
    */
    // echo !empty($comments) ? "There are comments":
    //                         'No comments';
    
    // $first_comment = !empty($comments) 
    //                 ? $comments[0] :'No comments';
    //coalescing operator
    // $first_comment = $comments[0] ?? 'No comments'; 
    // echo $first_comment;
    
    $favorite_color = 'red';
    switch($favorite_color) {
        case 'red':
            echo 'You choose RED';
            break;
        case 'green':
            echo 'You choose GREEN';
            break;
        case 'blue':
            echo 'You choose BLUE';
            break;
        default: 
            echo 'Not RED, GREEN, BLUE';
    }

?>