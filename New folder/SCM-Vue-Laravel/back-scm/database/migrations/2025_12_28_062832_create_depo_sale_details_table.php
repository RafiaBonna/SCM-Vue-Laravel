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
    Schema::create('depo_sale_details', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('depo_sale_id');
        $table->unsignedBigInteger('product_id');
        $table->decimal('quantity', 12, 2);
        $table->decimal('unit_price', 12, 2);
        $table->decimal('subtotal', 15, 2);
        $table->timestamps();

        $table->foreign('depo_sale_id')->references('id')->on('depo_sales')->onDelete('cascade');
        $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('depo_sale_details');
    }
};
