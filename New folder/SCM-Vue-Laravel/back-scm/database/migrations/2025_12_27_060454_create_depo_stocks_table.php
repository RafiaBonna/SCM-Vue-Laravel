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
    Schema::create('depo_stocks', function (Blueprint $table) {
        $table->id();
        $table->foreignId('depo_id')->constrained('depos')->onDelete('cascade');
        $table->foreignId('product_id')->constrained('products')->onDelete('cascade');
        $table->decimal('opening_stock', 12, 2)->default(0);
        $table->decimal('received_qty', 12, 2)->default(0);
        $table->decimal('receive_return_qty', 12, 2)->default(0);
        $table->decimal('sales_qty', 12, 2)->default(0);
        $table->decimal('sales_return_qty', 12, 2)->default(0);
        $table->decimal('wastage_qty', 12, 2)->default(0);
        $table->decimal('current_stock', 12, 2)->default(0);
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('depo_stocks');
    }
};
