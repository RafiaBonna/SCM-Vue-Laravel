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
    Schema::create('product_receive_returns', function (Blueprint $table) {
        $table->id();
        $table->string('return_number')->unique();
        $table->date('return_date');
        $table->foreignId('product_id')->constrained()->onDelete('cascade');
        $table->decimal('quantity', 12, 2);
        $table->text('reason')->nullable();
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('product_receive_returns');
    }
};
