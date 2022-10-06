<?php
    //echo "We talk about Array<br>";
    $some_numers = [1,3,4,6];
    $fruits = array('pineapple', 'melon', 'apple');
    // print_r($fruits);
    // echo $fruits[2];
    //associative array
    $colors = [
        3 => 'red',//key - value
        5 => 'green',
        7 => 'blue'
    ];
    //echo $colors[7];
    //key as a string
    $hex_colors = [
        'red' => '#FF0000',
        'green' => '#00FF00',
        'blue' => '#0000FF',  
    ];
    // echo $hex_colors['green'];
    $person = [
        'full_name' => 'Nguyen Duc Hoang',
        'age' => 43,
        'email' => 'sunlight4d@gmail.com' 
    ];
    //print_r($person);
    //echo $person['email'];
    $persons = [
        [
            'full_name' => 'Nguyen Duc Hoang',
            'age' => 43,
            'email' => 'sunlight4d@gmail.com' 
        ],
        [
            'full_name' => 'John Dang',
            'age' => 18,
            'email' => 'john@gmail.com' 
        ],
        [
            'full_name' => 'Kelly',
            'age' => 40,
            'email' => 'kelly123@gmail.com' 
        ]
    ];
    //print_r($persons);
    //echo $persons[2]['email'];
    var_dump(json_encode($persons));
?>