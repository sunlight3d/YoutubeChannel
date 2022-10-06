@extends('layouts.app')

@section('content')
<h1>PageController.index, with shared Header, Footer</h1>
{{-- The storage is more secure ! --}}
<img 
    src="{{ asset('storage/pen-icon.png') }}" 
    width="100"
    height="100"
    alt="">
@endsection
