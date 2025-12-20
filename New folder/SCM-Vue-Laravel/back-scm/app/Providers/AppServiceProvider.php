<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Models\ProductReceive; // ProductReceive model import
use App\Observers\ProductReceiveObserver; // Observer import

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
        // ProductReceive model-er jonno Observer register kora holo
        ProductReceive::observe(ProductReceiveObserver::class);
    }
}