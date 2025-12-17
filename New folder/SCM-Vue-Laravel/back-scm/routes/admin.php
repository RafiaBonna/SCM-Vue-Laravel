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

        // Settings (Depo, Supplier, Unit)
        Route::apiResource('depos', DepoController::class);
        Route::apiResource('suppliers', SupplierController::class);
        Route::apiResource('units', UnitController::class);

        // Raw Material Management
        Route::get('raw-materials/form-data', [RawMaterialController::class, 'getFormData']);
        Route::apiResource('raw-materials', RawMaterialController::class);

        // Purchase Management (Stock In)
        Route::get('purchases/form-data', [PurchaseController::class, 'getFormData']);
        Route::get('purchases', [PurchaseController::class, 'index']);
        Route::get('purchases/{id}', [PurchaseController::class, 'show']);
        Route::post('purchases', [PurchaseController::class, 'store']);

        // Material Issue Management (Stock Out)
        Route::get('material-issues/form-data', [MaterialIssueController::class, 'getFormData']);
        Route::apiResource('material-issues', MaterialIssueController::class);

        // ==================================================
        // Finished Goods & Production Management ✅
        // ==================================================

        // ১. প্রোডাক্ট লিস্ট এবং অন্যান্য ডাটা (ড্রপডাউনের জন্য)
        // এটি রিসিভ ফর্মের সময় কাজে লাগবে
        Route::get('product-receives/form-data', [ProductReceiveController::class, 'getFormData']);

        // ২. মেইন প্রোডাক্ট এন্ট্রি রাউট
        Route::apiResource('products', ProductController::class);

        // ৩. প্রোডাক্ট রিসিভ (কারখানা থেকে গ্রহণ) রাউট
        Route::apiResource('product-receives', ProductReceiveController::class);

    });