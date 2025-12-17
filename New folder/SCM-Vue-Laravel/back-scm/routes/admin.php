<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\PurchaseController;
use App\Http\Controllers\Api\Admin\MaterialIssueController;

/*
|--------------------------------------------------------------------------
| Admin API Routes
|--------------------------------------------------------------------------
| Base URL  : /api/admin/...
| Middleware: auth:sanctum
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
        // Purchase Management (Stock In)
        // URL: /api/admin/purchases
        // ==================================================
        Route::get(
            'purchases/form-data',
            [PurchaseController::class, 'getFormData']
        );

        Route::get('purchases', [PurchaseController::class, 'index']);
        Route::get('purchases/{id}', [PurchaseController::class, 'show']);
        Route::post('purchases', [PurchaseController::class, 'store']);

        // ==================================================
        // Material Issue Management (Stock Out) ✅
        // Factory তে Raw Material পাঠানো
        // URL: /api/admin/material-issues
        // ==================================================
        
        // ১. ড্রপডাউনের জন্য মেটেরিয়াল লিস্ট আনার রাউট
        Route::get(
            'material-issues/form-data', 
            [MaterialIssueController::class, 'getFormData']
        );

        // ২. মেইন রিসোর্স রাউট
        Route::apiResource(
            'material-issues',
            MaterialIssueController::class
        );

    });