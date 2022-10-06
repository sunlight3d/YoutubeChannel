<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
//controller has been overwritten
class ProductsController extends Controller
{
    public function index() {
        //how to pass data to view ?
        $title = 'Laravel Course from Nguyen Duc Hoang';
        $x = 1;
        $y = 2;
        //return view('products.index', compact('title', 'x', 'y'));
        $name = 'Hoang';
        //return view('products.index')->with('name', $name);
        //'with' method can only send 1 parameter
        //send an associative array
        $myphone = [
            'name' => 'iphone 14',
            'year' => 2022,
            'isFavorited' => true,
        ];
        //return view('products.index', compact('myphone'));
        //send directly        
        // return view('products.index', [
        //     'myphone' => $myphone
        // ]);
        print_r(route('products')); //it prints route's name
        return view('products.index');    
    }
    public function about() {
        return 'This is About page';
    }
    public function detail($productName, $id) {
        return "product's name = ".$productName.
                " ,product's id = ".$id ;
        
        // $phones = [
        //     'iphone 15' => 'iphone 15',
        //     'samsung' => 'samsung'
        // ];
        // return view('products.index', [
        //     'product' => $phones[$productName] ?? 'unknown product',
        // ]);
    }
}
