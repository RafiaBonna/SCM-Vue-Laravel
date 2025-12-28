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
        Schema::table('product_sales', function (Blueprint $table) {
            // 'note' কলামের পরে 'reject_note' কলামটি যোগ করা হচ্ছে
            $table->text('reject_note')->nullable()->after('note');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('product_sales', function (Blueprint $table) {
            // মাইগ্রেশন রোলব্যাক করলে কলামটি ডিলিট হয়ে যাবে
            $table->dropColumn('reject_note');
        });
    }
};