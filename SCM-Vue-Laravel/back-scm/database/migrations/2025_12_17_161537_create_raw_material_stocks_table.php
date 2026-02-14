<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('raw_material_stocks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('raw_material_id')->constrained('raw_materials')->onDelete('cascade');
            $table->decimal('quantity', 15, 2);
            $table->enum('type', ['in', 'out']); // 'in' মানে স্টক এসেছে, 'out' মানে খরচ হয়েছে
            $table->string('reference_id')->nullable(); // এখানে পারচেজ আইডি বা সেলস আইডি থাকবে
            $table->text('note')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('raw_material_stocks');
    }
};