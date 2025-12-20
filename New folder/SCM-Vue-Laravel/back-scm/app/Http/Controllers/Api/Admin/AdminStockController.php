<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\AdminStock;
use Illuminate\Http\Request;

class AdminStockController extends Controller
{
    public function index()
    {
        // প্রোডাক্টের নামসহ স্টকের সব ডাটা নিয়ে আসা
        return AdminStock::with('product')->get();
    }
}