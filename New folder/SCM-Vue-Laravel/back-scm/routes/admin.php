<?php

use Illuminate\Support\Facades\Route;

// ==============================
// Controller Imports
// ==============================
use App\Http\Controllers\Api\Admin\UserController;
use App\Http\Controllers\Api\Admin\DepoController;
use App\Http\Controllers\Api\Admin\SupplierController;
use App\Http\Controllers\Api\Admin\UnitController;
use App\Http\Controllers\Api\Admin\RawMaterialController;
use App\Http\Controllers\Api\Admin\PurchaseController;
use App\Http\Controllers\Api\Admin\MaterialIssueController;
use App\Http\Controllers\Api\Admin\ProductController;
use App\Http\Controllers\Api\Admin\ProductReceiveController;
use App\Http\Controllers\Api\Admin\ProductReceiveReturnController;
use App\Http\Controllers\Api\Admin\ProductWastageController;
use App\Http\Controllers\Api\Admin\AdminStockController;
use App\Http\Controllers\Api\Admin\ProductSaleController;

/*
|--------------------------------------------------------------------------
| Admin API Routes
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')
    ->prefix('admin')
    ->group(function () {

        // ==============================
        // User Management
        // ==============================
        Route::apiResource('users', UserController::class);

        // ==============================
        // System Settings
        // ==============================
        Route::apiResource('depos', DepoController::class);
        Route::apiResource('suppliers', SupplierController::class);
        Route::apiResource('units', UnitController::class);

        // ==============================
        // Raw Material Management
        // ==============================
        Route::get('raw-materials/form-data', [RawMaterialController::class, 'getFormData']);
        Route::apiResource('raw-materials', RawMaterialController::class);

        // ==============================
        // Purchase Management (Raw Material Stock In)
        // ==============================
        Route::get('purchases/form-data', [PurchaseController::class, 'getFormData']);
        Route::get('purchases', [PurchaseController::class, 'index']);
        Route::get('purchases/{id}', [PurchaseController::class, 'show']);
        Route::post('purchases', [PurchaseController::class, 'store']);

        // ==============================
        // Material Issue (Raw Material Stock Out)
        // ==============================
        Route::get('material-issues/form-data', [MaterialIssueController::class, 'getFormData']);
        Route::apiResource('material-issues', MaterialIssueController::class);

        // ==============================
        // Finished Goods & Production
        // ==============================

        // Product Master
        Route::apiResource('products', ProductController::class);

        // Product Receive (Finished Goods Stock In)
        Route::get('product-receives/get-form-data', [ProductReceiveController::class, 'getFormData']);
        Route::apiResource('product-receives', ProductReceiveController::class);

        // Product Receive Return (Finished Goods Stock Return)
        Route::get('product-returns', [ProductReceiveReturnController::class, 'index']);
        Route::post('product-returns', [ProductReceiveReturnController::class, 'store']);

        // ==============================
        // Product Wastage (Finished Goods / Production Loss)
        // ==============================
        Route::get('product-wastages', [ProductWastageController::class, 'index']);
        Route::post('product-wastages', [ProductWastageController::class, 'store']);

        // ==============================
        // Product Sales (Finished Goods Stock Transfer)
        // ==============================
        Route::get('product-sales', [ProductSaleController::class, 'index']);
        Route::post('product-sales', [ProductSaleController::class, 'store']);
        Route::get('product-sales/{id}', [ProductSaleController::class, 'show']);

        // ==============================
        // Stock Summary / Admin Stocks
        // ==============================
        Route::get('admin-stocks', [AdminStockController::class, 'index']);
    });
