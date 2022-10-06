<?php
    $y = 22;
    //echo "This lesson is about function";
    //function is a "block of code", with name
    function sayHello($name) { //function with "arguments"
        global $y;
        echo "y = $y";
        $x = 123;
        echo "Hello $name";
    }
    //echo "x = $x";
    //sayHello("Hoang"); //call function with "parameters"
    function sum($a = 0, $b = 0) {
        //default arguments' values
        return $a + $b;
    }
    //echo sum(2, 3);
    //assign a variable to a function
    $multiply = function ($a, $b) {
        return $a * $b;
    };
    //echo $multiply(3,4);
    //arrow function
    $substract = fn($a, $b) => $a - $b;
    //echo $substract(6, 2);
    //some built-in function for array
    $names = ['john', 'anna', 'hoang', 'tony'];
    //echo "number of items : ".count($names);
    //seach inside array
    //var_dump(in_array('hoang', $names));
    //insert an item
    array_push($names, 'elon', 'tom');
    //insert to the beginning of the array
    array_unshift($names, 'satoshi');
    //remote the last item
    array_pop($names);
    //remove the first item
    array_shift($names);
    //how to remote an item
    //unset($names[3]);
    //chunk an array
    $chunked_array = array_chunk($names, 3);
    //print_r($chunked_array);
    $array_one = [1, 3, 5];
    $array_two = [2, 4, 6];
    $merged_array = array_merge($array_one, $array_two);    
    //spread operator 
    $array_three = [...$merged_array];//clone an array
    $merged_array[0] = 111;
    //print_r($merged_array);
    //print_r($array_three);
    //merge and clone
    $array_four = [...$array_one, ...$array_two];
    //print_r($array_four);
    //combine two arrays
    $a = ['name', 'email', 'age'];
    $b = ['Hoang', 'sunlight4d@gmail.com', 18];
    $c = array_combine($a, $b);
    //print_r($c);
    //print_r(array_flip($c));
    // print_r(array_keys($c));
    // print_r(array_values($c));
    //array from a range
    $numbers = range(0, 10);
    print_r($numbers);
    //map an array to another array
    //with the same size, but other values
    $squared_numbers = array_map(fn($each_number) => 
        $each_number * $each_number
    , $numbers);
    print_r($squared_numbers);
    //filter an array
    $filtered_numbers = array_filter($numbers, 
        fn($each_number) => $each_number % 2 == 0);
    print_r($filtered_numbers);

?> 