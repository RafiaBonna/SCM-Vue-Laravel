<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('admin_stocks', function (Blueprint $blueprint) {
            $blueprint->id();
            $blueprint->foreignId('product_id')->constrained()->onDelete('cascade');
            
            // Stock Calculations
            $blueprint->decimal('opening_stock', 12, 2)->default(0);
            $blueprint->decimal('received_qty', 12, 2)->default(0);      // Factory Receive (+)
            $blueprint->decimal('receive_return_qty', 12, 2)->default(0); // Factory Return (-)
            $blueprint->decimal('sales_qty', 12, 2)->default(0);        // Depo Sale (-)
            $blueprint->decimal('sales_return_qty', 12, 2)->default(0);  // Depo Return (+)
            $blueprint->decimal('wastage_qty', 12, 2)->default(0);      // Nosto/Wastage (-)
            $blueprint->decimal('current_stock', 12, 2)->default(0);    // Final Balance
            
            $blueprint->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('admin_stocks');
    }
};