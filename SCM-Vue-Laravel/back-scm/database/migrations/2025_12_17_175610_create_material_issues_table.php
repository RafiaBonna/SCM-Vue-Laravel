<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('material_issues', function (Blueprint $table) {
            $table->id();
            $table->string('issue_number')->unique(); // যেমন: ISS-20231001
            $table->date('issue_date');
            $table->text('note')->nullable();
            $table->timestamps();
        });

        // আইটেমগুলোর জন্য টেবিল (আলাদা মডেল না করে এখানেই করা ভালো)
        Schema::create('material_issue_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('material_issue_id')->constrained()->onDelete('cascade');
            $table->foreignId('raw_material_id')->constrained();
            $table->decimal('quantity', 15, 2);
            $table->string('batch_no')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('material_issue_items');
        Schema::dropIfExists('material_issues');
    }
};