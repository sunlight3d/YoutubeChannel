<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PostsController extends Controller
{
    public function index() {
        //Query builders
        // $posts = DB::select("SELECT * FROM posts WHERE id = :id;",
        // [
        //     'id' => 3
        // ]);
        $posts = DB::table("posts")
                    ->where('id', '=', 5)
                    ->delete();
                    // ->update([
                    //     'title' => 'haha title',
                    //     'body' => 'This is haha body',
                    // ]);

                    // ->insert([
                    //     'title' => 'haha',
                    //     'body' => 'A new post hahaha'
                    // ]);

                    //->avg('id');//average
                    //->sum('id');
                    //->min('id');
                    //->count();
                    //->find(3);//find by id
                    //->whereNotNull("body")
                    //->oldest()                    
                    //->latest()
                    //->orderBy('id', 'asc')
                    // ->whereBetween("id", [1, 3])                    
                    // ->where("created_at",">", now()->subDay())
                    // ->orWhere('id', '>', 0)
                    //->select('body')
                    //->first();
                    //->get();

        dd($posts); //dd = die dump
        //return view('posts.index');
    }
}
