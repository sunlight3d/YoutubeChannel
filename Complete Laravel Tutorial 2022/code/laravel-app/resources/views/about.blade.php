@extends('layouts.app')

@section('content')
<h1>This is About Page, with shared Header,Footer</h1>
{{ 
    $x = 1;
 }}
@if ($x > 2)
    <h3>x is greater than 2</h3>
@elseif($x < 0) 
    <h3>x is less than 10</h3>
@else
    <h3>All conditions does not match</h3>
@endif
{{-- unless = "if not" --}}

{{-- @unless (empty($name))
    <h3>Name is not empty</h3>
@endunless --}}
{{-- @if(!empty($name))
    <h3>Name is not empty, haha</h3>
@endif --}}
{{--
@empty(!$name)
    <h3>Name is NOT empty</h3>
@endempty
@empty($age)
    <h3>Age is empty</h3>
@endempty
@isset($name)
    <h3>Name has been set</h3>
@endisset

@switch($name)
    @case('Hoang')
        <h3>This is mr Hoang</h3>
        @break
    @case('Henry')
        <h3>This is Henry</h3>
        @break
    @default
        <h3>No one selected</h3>
@endswitch
@for ($i = 0; $i < 5; $i++)
    <h2>i = {{ $i }}</h2>
@endfor

@foreach ($names as $eachName)
   <h3>each name : {{ $eachName }}</h3> 
@endforeach

@forelse ($names as $eachName)
    <h3>each name : {{ $eachName }}</h3>
@empty
    <h3>The array is empty</h3>
@endforelse

{{ $i = 0 }}
@while ($i < 10)
    <h3>i = {{ $i }}</h3>
    {{ $i++; }}
@endwhile
--}}

@endsection
    