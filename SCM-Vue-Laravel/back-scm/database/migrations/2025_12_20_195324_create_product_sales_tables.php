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
    // ১. মূল সেলস বা ট্রান্সফার টেবিল
    Schema::create('product_sales', function (Blueprint $table) {
        $table->id();
        $table->string('invoice_no')->unique();
        $table->date('sale_date');
        $table->foreignId('depo_id')->constrained('depos')->onDelete('cascade');
        $table->decimal('total_amount', 15, 2)->default(0);
        $table->enum('status', ['pending', 'accepted', 'rejected'])->default('pending');
        $table->text('note')->nullable();
        $table->timestamps();
    });

    // ২. সেলস আইটেম ডিটেইলস টেবিল
    Schema::create('product_sales_details', function (Blueprint $table) {
        $table->id();
        $table->foreignId('product_sale_id')->constrained('product_sales')->onDelete('cascade');
        $table->foreignId('product_id')->constrained('products')->onDelete('cascade');
        $table->decimal('quantity', 12, 2);
        $table->decimal('unit_price', 12, 2);
        $table->decimal('subtotal', 15, 2);
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('product_sales_tables');
    }
};
