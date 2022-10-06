@extends('layouts.app')

@section('content')
  <h1>This is Foods Page</h1>  
  <a href="foods/create" 
    class="btn btn-primary"
    role="button">
      Create a new Food
  </a>
  
  @foreach ($foods as $food)
  <li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
    <div class="fw-bold">
      <a href="/foods/{{ $food->id }}">
        {{-- Like "show details" --}}
        {{ $food->name }}
      </a>      
    </div>
    {{ $food->description }}
    </div>
    <span class="badge bg-primary rounded-pill">
        {{ $food->count }}
    </span>
    <a href="foods/{{ $food->id }}/edit">
        Edit
    </a>
    {{-- Delete a food --}}
    <form action="/foods/{{ $food->id }}" method="post">
      @csrf
      @method('delete')
      <button type="submit" class="btn btn-danger">
        Delete
      </button>
    </form>
  </li>          
  @endforeach
</ol>
@endsection