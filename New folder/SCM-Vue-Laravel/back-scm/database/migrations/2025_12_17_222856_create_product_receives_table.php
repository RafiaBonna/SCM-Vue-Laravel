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
    Schema::create('product_receives', function (Blueprint $table) {
        $table->id();
        $table->string('receive_number')->unique(); // e.g., REC-12345
        $table->date('receive_date');
        $table->foreignId('product_id')->constrained();
        $table->decimal('quantity', 15, 2);
        $table->string('batch_no')->nullable();
        $table->text('note')->nullable();
        $table->timestamps();
    });
}
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('product_receives');
    }
};
