<?php

use Illuminate\Support\Facades\Route;

// ===============================
// Depo Controllers
// ===============================
use App\Http\Controllers\Api\Depo\DepoProductReceiveController;
use App\Http\Controllers\Api\Depo\UserManagementController;
use App\Http\Controllers\Api\Depo\DepoSaleController;

/*
|--------------------------------------------------------------------------
| Depo API Routes
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')
    ->prefix('depo')
    ->group(function () {

        // ==================================================
        // Product Receive (Admin → Depo)
        // ==================================================
        Route::get('product-receives', [
            DepoProductReceiveController::class,
            'index'
        ]);

        Route::post('product-receives/accept/{id}', [
            DepoProductReceiveController::class,
            'acceptTransfer'
        ]);

        Route::post('product-receives/reject/{id}', [
            DepoProductReceiveController::class,
            'rejectTransfer'
        ]);

        // ==================================================
        // Current Stock
        // ==================================================
        Route::get('current-stock', [
            DepoProductReceiveController::class,
            'currentStock'
        ]);

        // ==================================================
        // Invoice View
        // ==================================================
        Route::get('invoice/{id}', [
            DepoProductReceiveController::class,
            'viewInvoice'
        ]);

        // ==================================================
        // Distributor Management (OLD + NEW)
        // ==================================================
        Route::get('distributors', [UserManagementController::class, 'getDistributors']);
        Route::post('distributors/store', [UserManagementController::class, 'storeDistributor']);
        Route::get('distributors/edit/{id}', [UserManagementController::class, 'editDistributor']);
        Route::post('distributors/update/{id}', [UserManagementController::class, 'updateDistributor']);

    

        // ==================================================
        // Customer Management (OLD + NEW)
        // ==================================================
        Route::get('customers', [
            UserManagementController::class,
            'getCustomers'             // old
        ]);

        Route::get('customers', [
            UserManagementController::class,
            'indexCustomer'            // new
        ]);

        Route::post('customers/store', [
            UserManagementController::class,
            'storeCustomer'            // old
        ]);

        Route::post('customers', [
            UserManagementController::class,
            'storeCustomer'            // new
        ]);

        // ==================================================
        // Depo Sales
        // ==================================================
        Route::get('sales', [
            DepoSaleController::class,
            'index'
        ]);

        Route::post('sales/store', [
            DepoSaleController::class,
            'store'
        ]);

        // ==================================================
        // Distributor Sales Actions
        // ==================================================
        Route::post('sales/accept/{id}', [
            DepoSaleController::class,
            'acceptByDistributor'
        ]);

        Route::post('sales/reject/{id}', [
            DepoSaleController::class,
            'rejectByDistributor'
        ]);
    });
