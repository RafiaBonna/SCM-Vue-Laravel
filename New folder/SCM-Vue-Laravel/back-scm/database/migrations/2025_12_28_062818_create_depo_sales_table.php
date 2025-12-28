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
    Schema::create('depo_sales', function (Blueprint $table) {
        $table->id();
        $table->string('invoice_no')->unique();
        $table->date('sale_date');
        $table->unsignedBigInteger('depo_id');
        $table->enum('sale_type', ['distributor', 'customer']); // বিক্রির ধরণ
        $table->unsignedBigInteger('sale_to_id'); // ডিস্ট্রিবিউটর বা কাস্টমার আইডি
        $table->decimal('total_amount', 15, 2)->default(0);
        $table->enum('status', ['pending', 'accepted', 'rejected'])->default('pending');
        $table->text('note')->nullable(); // সাধারণ নোট
        $table->text('reject_note')->nullable(); // ডিস্ট্রিবিউটর রিজেক্ট করলে কারণ এখানে থাকবে
        $table->timestamps();

        $table->foreign('depo_id')->references('id')->on('depos')->onDelete('cascade');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('depo_sales');
    }
};
