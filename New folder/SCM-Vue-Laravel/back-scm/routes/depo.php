<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Depo\DepoProductReceiveController;

// Depo API Routes
Route::middleware(['auth:sanctum'])
    ->prefix('depo')
    ->group(function () {
        
        // প্রোডাক্ট রিসিভ লিস্ট দেখার রুট
        Route::get('product-receives', [DepoProductReceiveController::class, 'index']);
        
        // মাল গ্রহণ (Accept) করার রুট
        Route::post('product-receives/accept/{id}', [DepoProductReceiveController::class, 'acceptTransfer']);
        
    });