<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\ProductReceive;
use Illuminate\Http\Request;

class ProductReceiveController extends Controller
{
    // ১. ড্রপডাউনের জন্য প্রোডাক্ট লিস্ট পাঠানো ✅
    public function getFormData()
    {
        $products = Product::select('id', 'name', 'sku', 'unit')->where('status', 1)->get();
        return response()->json([
            'products' => $products
        ]);
    }

    // ২. রিসিভ করা মালের তালিকা
    public function index()
    {
        return ProductReceive::with('product')->orderBy('id', 'desc')->get();
    }

    // ৩. কারখানা থেকে মাল রিসিভ করা (Store)
    public function store(Request $request)
    {
        $request->validate([
            'receive_date' => 'required|date',
            'product_id'   => 'required|exists:products,id',
            'quantity'     => 'required|numeric|min:0.01',
        ]);

        $receive = ProductReceive::create([
            'receive_number' => 'PRC-' . time(),
            'receive_date'   => $request->receive_date,
            'product_id'     => $request->product_id,
            'quantity'       => $request->quantity,
            'batch_no'       => $request->batch_no,
            'note'           => $request->note,
        ]);

        return response()->json([
            'message' => 'Product received successfully!', 
            'receive' => $receive
        ], 201);
    }

    // ৪. ইনভয়েস/স্লিপ দেখার জন্য ডাটা
    public function show($id)
    {
        return ProductReceive::with('product')->findOrFail($id);
    }
}