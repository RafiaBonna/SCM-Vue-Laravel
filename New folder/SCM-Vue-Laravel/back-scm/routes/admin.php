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
    ->namespace('App\Http\Controllers\Api\Admin')
    ->group(function () {

        // ==================================================
        // User Management
        // URL: /api/admin/users
        // ==================================================
        Route::apiResource('users', 'UserController');

        // ==================================================
        // Depo Management
        // URL: /api/admin/depos
        // ==================================================
        Route::apiResource('depos', 'DepoController');

        // ==================================================
        // Supplier Management
        // URL: /api/admin/suppliers
        // ==================================================
        Route::apiResource('suppliers', 'SupplierController');

        // ==================================================
        // Unit Management
        // URL: /api/admin/units
        // ==================================================
        Route::apiResource('units', 'UnitController');

        // ==================================================
        // Raw Material Management
        // URL: /api/admin/raw-materials
        // ==================================================
        Route::get('raw-materials/form-data', 'RawMaterialController@getFormData');
        Route::apiResource('raw-materials', 'RawMaterialController');

        // ==================================================
        // Purchase Management ✅ NEW
        // URL: /api/admin/purchases
        // ==================================================
        // Form dropdown data (suppliers, raw materials, etc.)
        Route::get('purchases/form-data', [PurchaseController::class, 'getFormData']);

        // CRUD
        Route::get('purchases', [PurchaseController::class, 'index']);
        Route::get('purchases/{id}', [PurchaseController::class, 'show']);
        Route::post('purchases', [PurchaseController::class, 'store']);
        // Optional: update & delete if needed
        // Route::put('purchases/{id}', [PurchaseController::class, 'update']);
        // Route::delete('purchases/{id}', [PurchaseController::class, 'destroy']);
    });
