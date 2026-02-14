<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('raw_materials', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique(); 

            // Basic Unit (e.g. KG, Litre)
            $table->foreignId('unit_id')->constrained('units'); 

            // Alert Stock (Minimum level)
            $table->decimal('alert_stock', 10, 2)->default(0); 

            $table->text('description')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('raw_materials');
    }
};