<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\ProductReceiveReturn;
use Illuminate\Http\Request;

class ProductReceiveReturnController extends Controller
{
    // রিটার্ন লিস্ট দেখার জন্য
    public function index()
    {
        return ProductReceiveReturn::with('product')->orderBy('id', 'desc')->get();
    }

    // নতুন রিটার্ন সেভ করার জন্য
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|numeric|min:1',
            'return_date' => 'required|date',
        ]);

        // অটোমেটিক রিটার্ন নাম্বার জেনারেট করা
        $returnNumber = 'RET-' . strtoupper(uniqid());

        $return = ProductReceiveReturn::create([
            'return_number' => $returnNumber,
            'return_date' => $request->return_date,
            'product_id' => $request->product_id,
            'quantity' => $request->quantity,
            'reason' => $request->reason,
        ]);

        return response()->json(['message' => 'Return recorded successfully', 'data' => $return]);
    }
}