<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Depo\DepoProductReceiveController;

// Depo API Routes
Route::middleware(['auth:sanctum'])
    ->prefix('depo')
    ->group(function () {
        
        // Product Receive Routes
        Route::get('product-receives', [DepoProductReceiveController::class, 'index']);
        Route::post('product-receives/accept/{id}', [DepoProductReceiveController::class, 'acceptTransfer']);

        // === EI LINE TI JOG KORUN ===
        Route::get('current-stock', [DepoProductReceiveController::class, 'currentStock']);
        // ইনভয়েস ডাটা পাওয়ার জন্য এই রাউটটি অবশ্যই লাগবে
    Route::get('/invoice/{id}', [DepoProductReceiveController::class, 'viewInvoice']);
        
    });