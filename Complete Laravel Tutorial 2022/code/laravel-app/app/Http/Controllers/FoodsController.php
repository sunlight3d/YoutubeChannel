<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Food;
use App\Models\Category;
use App\Rules\Uppercase;
use App\Http\Requests\CreateValidationRequest;

class FoodsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $foods = Food::all(); //SELECT * FROM foods;        
        // $food = Food::where('name','=','sushi')
        //             ->firstOrFail();
        
        //dd($foods);
        //var_dump($foods);
        return view('foods.index', [
            'foods' => $foods,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //insert new food
        $categories = Category::all();
        return view('foods.create', [
            'categories' => $categories,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //dd($request->all());
        //dd($request->file('image')->guessExtension());//jpg, jpeg,...
        //dd($request->file('image')->getSize()); //kilobytes
        //dd($request->file('image')->getError());
        //dd($request->file('image')->isValid());
        $request->validate([
            'name' => 'required',
            'count' => 'required|integer|min:0|max:200',
            'description' => 'required',
            'image' => 'required|mimes:jpg,png,jpeg|max:5048'
        ]);
        //client image's name and server's image name
        //must be different, why ??
        $generatedImageName = 'image'.time().'-'
                                .$request->name.'.'
                                .$request->image->extension();
        //move to a folder
        $request->image->move(public_path('images'), $generatedImageName);
        //dd('This is store function');
        // $food = new Food();
        // $food->name = $request->input('name');
        // $food->count = $request->input('count');
        // $food->description = $request->input('description');
        //$request->validated();
        //we need validate data here
        // $request->validate([
        //     //'name' => 'required|unique:foods',
        //     'name' => new Uppercase,
        //     'count' => 'required|integer|min:0|max:1000',
        //     'category_id' => 'required',
        // ]);
        //if the validation is pass, it will come here !
        //Otherwise it will throw an exception(ValidationException)
        $food = Food::create([
            'name' => $request->input('name'),
            'count' => $request->input('count'),
            'description' => $request->input('description'),
            'category_id' => $request->input('category_id'),
            'image_path' => $generatedImageName
        ]);
        //save to Database
        $food->save();
        return redirect('/foods');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id) //like "show details"
    {
        //dd('This is show, id = '.$id);
        $food = Food::find($id);
        //$category = $food->category();
        $category = Category::find($food->category_id);
        //dd($category);
        $food->category = $category;
        //dd($food);
        return view('foods.show')->with('food', $food);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //dd($id);
        $food = Food::find($id);
        //dd($food);
        return view('foods.edit')->with('food', $food);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(CreateValidationRequest $request, $id)
    {
        $request->validated();
        $food = Food::where('id', $id)  
                ->update([
                    'name' => $request->input('name'),
                    'count' => $request->input('count'),
                    'description' => $request->input('description'),
                ]);
        return redirect('/foods');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $food = Food::find($id);
        $food->delete();
        //dd($id);
        return redirect('/foods');
    }
}
