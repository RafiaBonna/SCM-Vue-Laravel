<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Depo\UserManagementController;

Route::middleware('auth:sanctum')
    ->prefix('depo')
    ->group(function () {

        // ... apnar onno route gulo thakbe ...

        // Distributor Management Routes
        Route::get('distributors', [UserManagementController::class, 'getDistributors']);
        Route::post('distributors/store', [UserManagementController::class, 'storeDistributor']);

        // --- EI 2 TI ROUTE NOTUN ADD KORA HOYECHE ---
        Route::get('distributors/edit/{id}', [UserManagementController::class, 'editDistributor']);
        Route::post('distributors/update/{id}', [UserManagementController::class, 'updateDistributor']);
        // --------------------------------------------

        // Customer Routes
        Route::get('customers', [UserManagementController::class, 'getCustomers']);
        Route::post('customers/store', [UserManagementController::class, 'storeCustomer']);

        // ... baki sob route ager motoi thakbe ...
    });
