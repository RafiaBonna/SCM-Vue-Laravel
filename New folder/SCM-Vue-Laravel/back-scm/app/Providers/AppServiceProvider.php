<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

// Model ও Observer গুলো ইম্পোর্ট করুন
use App\Models\ProductReceive;
use App\Models\ProductReceiveReturn;
use App\Models\ProductWastage; // নতুন যোগ হলো

use App\Observers\ProductReceiveObserver;
use App\Observers\ProductReceiveReturnObserver;
use App\Observers\ProductWastageObserver; // নতুন যোগ হলো

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // 1. Factory Receive Observer
        ProductReceive::observe(ProductReceiveObserver::class);

        // 2. Factory Return Observer
        ProductReceiveReturn::observe(ProductReceiveReturnObserver::class);

        // 3. Wastage Observer (নতুন যোগ করা হলো)
        ProductWastage::observe(ProductWastageObserver::class);
    }
}