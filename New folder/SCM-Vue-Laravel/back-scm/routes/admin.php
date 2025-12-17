<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\PurchaseController;

/*
|--------------------------------------------------------------------------
| Admin API Routes
|--------------------------------------------------------------------------
| Base URL  : /api/admin/...
| Middleware: auth:sanctum
| Namespace : App\Http\Controllers\Api\Admin
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')
    ->prefix('admin')
    ->group(function () {

        // ==================================================
        // User Management
        // URL: /api/admin/users
        // ==================================================
        Route::apiResource('users', \App\Http\Controllers\Api\Admin\UserController::class);

        // ==================================================
        // Depo Management
        // URL: /api/admin/depos
        // ==================================================
        Route::apiResource('depos', \App\Http\Controllers\Api\Admin\DepoController::class);

        // ==================================================
        // Supplier Management
        // URL: /api/admin/suppliers
        // ==================================================
        Route::apiResource('suppliers', \App\Http\Controllers\Api\Admin\SupplierController::class);

        // ==================================================
        // Unit Management
        // URL: /api/admin/units
        // ==================================================
        Route::apiResource('units', \App\Http\Controllers\Api\Admin\UnitController::class);

        // ==================================================
        // Raw Material Management
        // URL: /api/admin/raw-materials
        // ==================================================
        Route::get(
            'raw-materials/form-data',
            [\App\Http\Controllers\Api\Admin\RawMaterialController::class, 'getFormData']
        );
        Route::apiResource(
            'raw-materials',
            \App\Http\Controllers\Api\Admin\RawMaterialController::class
        );

        // ==================================================
        // Purchase Management (Stock In) ✅
        // URL: /api/admin/purchases
        // ==================================================

        // Form dropdown data
        Route::get(
            'purchases/form-data',
            [PurchaseController::class, 'getFormData']
        );

        // Purchase list
        Route::get(
            'purchases',
            [PurchaseController::class, 'index']
        );

        // Single purchase details
        Route::get(
            'purchases/{id}',
            [PurchaseController::class, 'show']
        );

        // Store new purchase (Stock In)
        Route::post(
            'purchases',
            [PurchaseController::class, 'store']
        );

        // (Optional future)
        // Route::put('purchases/{id}', [PurchaseController::class, 'update']);
        // Route::delete('purchases/{id}', [PurchaseController::class, 'destroy']);
    });
