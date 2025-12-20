<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\UserController;
use App\Http\Controllers\Api\Admin\DepoController;
use App\Http\Controllers\Api\Admin\SupplierController;
use App\Http\Controllers\Api\Admin\UnitController;
use App\Http\Controllers\Api\Admin\RawMaterialController;
use App\Http\Controllers\Api\Admin\PurchaseController;
use App\Http\Controllers\Api\Admin\MaterialIssueController;
use App\Http\Controllers\Api\Admin\ProductController;
use App\Http\Controllers\Api\Admin\ProductReceiveController;

/*
|--------------------------------------------------------------------------
| Admin API Routes
|--------------------------------------------------------------------------
*/

Route::middleware('auth:sanctum')
    ->prefix('admin')
    ->group(function () {

        // User Management
        Route::apiResource('users', UserController::class);

        // System Settings (Warehouse/Depo, Suppliers, Measurement Units)
        Route::apiResource('depos', DepoController::class);
        Route::apiResource('suppliers', SupplierController::class);
        Route::apiResource('units', UnitController::class);

        // Raw Material Management
        Route::get('raw-materials/form-data', [RawMaterialController::class, 'getFormData']);
        Route::apiResource('raw-materials', RawMaterialController::class);

        // Purchase Management (Stock Inbound from Suppliers)
        Route::get('purchases/form-data', [PurchaseController::class, 'getFormData']);
        Route::get('purchases', [PurchaseController::class, 'index']);
        Route::get('purchases/{id}', [PurchaseController::class, 'show']);
        Route::post('purchases', [PurchaseController::class, 'store']);

        // Material Issue Management (Stock Outbound to Production)
        Route::get('material-issues/form-data', [MaterialIssueController::class, 'getFormData']);
        Route::apiResource('material-issues', MaterialIssueController::class);

        // ==================================================
        // Finished Goods & Production Management
        // ==================================================

        // 1. Fetch metadata/dropdown list for Product Receive form
        Route::get('product-receives/get-form-data', [ProductReceiveController::class, 'getFormData']);

        // 2. Core Product Management (Master Data)
        Route::apiResource('products', ProductController::class);

        // 3. Product Receiving (Finished goods received from Factory)
        Route::apiResource('product-receives', ProductReceiveController::class);

    });