<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Depo\DepoProductReceiveController;

/*
|--------------------------------------------------------------------------
| Depo API Routes
|--------------------------------------------------------------------------
*/
Route::middleware(['auth:sanctum'])
    ->prefix('depo')
    ->group(function () {

        // ===============================
        // Product Receive (From Admin)
        // ===============================
        Route::get('product-receives', [DepoProductReceiveController::class, 'index']);
        Route::post('product-receives/accept/{id}', [DepoProductReceiveController::class, 'acceptTransfer']);
        Route::post('product-receives/reject/{id}', [DepoProductReceiveController::class, 'rejectTransfer']);

        // ===============================
        // Current Stock
        // ===============================
        Route::get('current-stock', [DepoProductReceiveController::class, 'currentStock']);

        // ===============================
        // Invoice View (Depo)
        // ===============================
        Route::get('invoice/{id}', [DepoProductReceiveController::class, 'viewInvoice']);
    });
