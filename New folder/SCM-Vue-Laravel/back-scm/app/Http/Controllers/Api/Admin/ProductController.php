<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index()
    {
        return Product::orderBy('id', 'desc')->get();
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'sku'  => 'required|string|unique:products,sku',
            'unit' => 'required|string',
            'mrp'  => 'nullable|numeric',
            'retail_rate'      => 'nullable|numeric',
            'distributor_rate' => 'nullable|numeric',
            'depo_rate'        => 'nullable|numeric',
            'description'      => 'nullable|string',
        ]);

        $product = Product::create($data);
        return response()->json(['message' => 'Product created successfully!', 'product' => $product], 201);
    }
}