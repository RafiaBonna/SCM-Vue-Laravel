<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Depo\DepoProductReceiveController;
use App\Http\Controllers\Api\Depo\UserManagementController;
use App\Http\Controllers\Api\Depo\DepoSaleController;

Route::middleware('auth:sanctum')
    ->prefix('depo')
    ->group(function () {

        // Product Receive & Stock
        Route::get('product-receives', [DepoProductReceiveController::class, 'index']);
        Route::post('product-receives/accept/{id}', [DepoProductReceiveController::class, 'acceptTransfer']);
        Route::post('product-receives/reject/{id}', [DepoProductReceiveController::class, 'rejectTransfer']);
        Route::get('current-stock', [DepoProductReceiveController::class, 'currentStock']);

        // ==================================================
        // Distributor Management (Fixed)
        // ==================================================
        Route::get('distributors', [UserManagementController::class, 'getDistributors']);
        Route::post('distributors/store', [UserManagementController::class, 'storeDistributor']);
        Route::get('distributors/edit/{id}', [UserManagementController::class, 'editDistributor']);
        Route::post('distributors/update/{id}', [UserManagementController::class, 'updateDistributor']);

        // ==================================================
        // Customer Management (Fixed)
        // ==================================================
        Route::get('customers', [UserManagementController::class, 'getCustomers']);
        Route::post('customers/store', [UserManagementController::class, 'storeCustomer']);

        // Sales
        Route::get('sales', [DepoSaleController::class, 'index']);
        Route::post('sales/store', [DepoSaleController::class, 'store']);
    });
