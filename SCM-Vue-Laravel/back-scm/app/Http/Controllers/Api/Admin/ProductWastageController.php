<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\ProductWastage;
use Illuminate\Http\Request;

class ProductWastageController extends Controller
{
    // সব Wastage লিস্ট দেখার জন্য
    public function index()
    {
        return ProductWastage::with('product')->orderBy('id', 'desc')->get();
    }

    // নতুন Wastage সেভ করার জন্য
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|numeric|min:1',
            'date' => 'required|date',
        ]);

        // অটোমেটিক ওয়েস্টেজ নাম্বার জেনারেট করা
        $wastageNumber = 'WST-' . strtoupper(uniqid());

        $wastage = ProductWastage::create([
            'wastage_number' => $wastageNumber,
            'date' => $request->date,
            'product_id' => $request->product_id,
            'quantity' => $request->quantity,
            'remarks' => $request->remarks,
        ]);

        return response()->json(['message' => 'Wastage recorded successfully', 'data' => $wastage]);
    }
}