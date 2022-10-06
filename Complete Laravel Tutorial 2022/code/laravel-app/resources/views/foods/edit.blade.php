@extends('layouts.app')

@section('content')
  <h1>Update a food</h1> 
  <form action="/foods/{{ $food-> id }}" method="post">    
      @csrf
      @method('PUT')        
      <input 
        class="form-control"
        type="text" 
        name="name"
        value="{{$food->name}}" 
        placeholder="Enter food's name">
    <input 
        class="form-control"
        type="text" 
        name="description"
        value="{{$food->description}}" 
        placeholder="Enter food's description">
    <input 
        class="form-control"
        type="text" 
        name="count" 
        value="{{$food->count}}" 
        placeholder="Enter food's count">
    <button 
        class="btn btn-primary"
        type="submit">
        Update Food
    </button>
  </form>
@endsection  