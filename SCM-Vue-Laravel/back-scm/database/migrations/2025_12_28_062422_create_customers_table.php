<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
  public function up(): void
{
    Schema::create('customers', function (Blueprint $table) {
        $table->id();
        $table->string('name');
        $table->string('phone');
        $table->text('address')->nullable();
        $table->unsignedBigInteger('depo_id'); // কোন ড্যাপো থেকে কাস্টমার কিনছে
        $table->timestamps();

        $table->foreign('depo_id')->references('id')->on('depos')->onDelete('cascade');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customers');
    }
};
