<?php
    //echo "OOP - Object Oriented Programming";
    //From PHP5 onwards, you can define classes    
    class User {
        //properties that belong to a class
        public $name;
        public $email;
        public $age;
        public $password;
        //constructor: function that runs when an object
        //is instantiated
        public function __construct($name, 
                                    $email, 
                                    $age, 
                                    $password) {
            //echo "constructor run<br>";
            $this->name = $name;
            $this->email = $email;
            $this->age = $age;
            $this->password = $password;            
        }
        //method: a function that belongs to a class
        function set_name($name) {
            $this->name = $name;
        }
        //getter
        function get_name() { return $this->name; }
    }
    //init an object
    $user1 = new User('john', 'john@gmail.com', 23, '11223');
    $user2 = new User('tony', 'tony@gmail.com', 19, 'abc12');    
    // $user1->name = 'Hoang';
    // $user1->age = 43;
    // $user1->email = 'sunlight4d@gmail.com';
    // $user1->password = '123456';
    //$user1->set_name('Hoang123');
    //$user2->set_name('Bob');
    // print_r($user1);
    // print_r($user2);
    // echo $user1->get_name()."<br>";
    // echo $user2->get_name();
    
    // echo $user2->email;    
    // echo $user2->name;
    //inheritance
    class Employee extends User {
        public function __construct($name, 
                                    $email, 
                                    $age, 
                                    $password,
                                    $title //only employee has
                                    ) {
            parent::__construct($name, $email, $age, $password);                                    
            $this->title = $title;
        }
        public function get_title() {
            return $this->title;
        }
    }
    $employee1 = new Employee('Taylor', 'taylor12@gmail.com', 
                        30,'123456','Sales manager');
    echo $employee1->get_title();                        
?>