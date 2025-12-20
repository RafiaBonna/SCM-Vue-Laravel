<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

// Model gulo import korun
use App\Models\ProductReceive;
use App\Models\ProductReceiveReturn;

// Observer gulo import korun
use App\Observers\ProductReceiveObserver;
use App\Observers\ProductReceiveReturnObserver;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // 1. Factory theke mal rishiiv korle stock barbe
        ProductReceive::observe(ProductReceiveObserver::class);

        // 2. Factory-te mal pherot pathale stock kombe
        ProductReceiveReturn::observe(ProductReceiveReturnObserver::class);
    }
}