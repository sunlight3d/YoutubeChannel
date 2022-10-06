<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductsController;
use App\Http\Controllers\PagesController;
use App\Http\Controllers\PostsController;
use App\Http\Controllers\FoodsController;

Route::get('/', [PagesController::class, 'index']);
Route::get('/about', [PagesController::class, 'about']);
Route::get('/posts', [PostsController::class, 'index']);
Auth::routes();
Route::resource('foods', FoodsController::class);

/*Route::get('/products', [
    ProductsController::class,
    'index' //index function of ProductsController
])->name('products');
*/

//how to validate "id only integer" ?
//Regular Expression
/*
Route::get('/products/{productName}/{id}', [
    ProductsController::class,
    'detail' 
])->where([
    'productName' => '[a-zA-Z0-9\s]+',
    'id' => '[0-9]+'
]);
*/
/*
Route::get('/products/{productName}', [
    ProductsController::class, 
    'detail' 
]);
 */

/*
Route::get('/products/about', [
    ProductsController::class,
    'about' 
]);

Route::get('/', function () {
    return view('home'); //response a view
    //return env('MY_NAME');
});


Route::get('/users', function () {
    return 'This is the users page';//response a string
});
//response an array 
Route::get('/foods', function () {
    return ['sushi', 'sashimi', 'tofu'];
});
//response an object
Route::get('/aboutMe', function () {
    return response()->json([
        'name' => 'Nguyen Duc Hoang',
        'email' => 'sunlight4d@gmail.com'
    ]); //response
});
//response another request = redirect
Route::get('/something', function () {
    return redirect('/foods');//redirect to foods
});
*/