<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\SupplierController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// ------------------------------
// Public Routes
// ------------------------------
Route::post('/login', [AuthController::class, 'login']);
// Registration optional
// Route::post('/register', [AuthController::class, 'register']);


// ------------------------------
// Protected Routes - Requires Sanctum Auth
// ------------------------------
Route::middleware('auth:sanctum')->group(function () {

    // ------------------------------
    // Authentication
    // ------------------------------
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/user', function (Request $request) {
        return $request->user();
    });


    // ------------------------------
    // User Management (CRUD)
    // ------------------------------
    Route::apiResource('users', UserController::class)->only([
        'index',
        'store',
        'show',
        'update',
        'destroy'
    ]);


    // ------------------------------
    // Supplier Management (CRUD)
    // ------------------------------
    Route::apiResource('suppliers', SupplierController::class);
});
