<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PagesController extends Controller
{
    public function index() {
        return view('index');
    }
    public function about() {
        $name = "Tony";
        $names = array('Hoang', 'David', 'John', 'Micheal','Taylor');
        //$names = [];
        return view('about', [
            'names' => $names,
        ]);
    }
    //Now Database and Migrations
}
