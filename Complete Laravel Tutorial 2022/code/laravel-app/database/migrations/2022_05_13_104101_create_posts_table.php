<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //php artisan migrate:refresh
        //php artisan migrate:fresh => donot call down()
        Schema::create('posts', function (Blueprint $table) {
            $table->increments('id');
            $table->string('title');
            $table->text('body');
            $table->timestamps();//created_at, updated_at
        });
    }

    /**
     * Reverse the migrations. => rollback/undo the migrations
     *
     * @return void
     */
    public function down()
    {
        //php artisan migrate:reset
        //will call this function
        Schema::dropIfExists('posts');
    }
};
