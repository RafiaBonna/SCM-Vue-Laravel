<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\ProductSale;
use App\Models\ProductSaleDetail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductSaleController extends Controller
{
    // ==============================
    // সব সেলস/ট্রান্সফার লিস্ট দেখার জন্য
    // ==============================
public function index()
{
    $sales = ProductSale::with(['depo', 'details.product'])
        ->orderBy('id', 'desc')
        ->get();

    return response()->json([
        'success' => true,
        'data' => $sales
    ]);
}
    // ==============================
    // নতুন সেলস/ট্রান্সফার এন্ট্রি করার জন্য
    // ==============================
    public function store(Request $request)
    {
        // ১. ইনপুট ভ্যালিডেশন
        $request->validate([
            'depo_id'    => 'required|exists:depos,id',
            'sale_date'  => 'required|date',
            'total_amount' => 'required|numeric|min:0',
            'items'      => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity'   => 'required|numeric|min:1',
            'items.*.unit_price' => 'required|numeric|min:0',
        ]);

        try {
            DB::beginTransaction();

            // ২. ইনভয়েস নম্বর জেনারেট করা
            $invoiceNo = 'INV-' . time() . rand(10, 99);

            // ৩. মূল সেলস ডাটা সেভ করা
            $sale = ProductSale::create([
                'invoice_no'   => $invoiceNo,
                'sale_date'    => $request->sale_date,
                'depo_id'      => $request->depo_id,
                'total_amount' => $request->total_amount,
                'status'       => 'pending', // ডিফল্ট পেন্ডিং থাকবে
                'note'         => $request->note ?? null,
            ]);

            // ৪. আইটেমগুলো লুপ করে সেভ করা
            foreach ($request->items as $item) {
                ProductSaleDetail::create([
                    'product_sale_id' => $sale->id,
                    'product_id'      => $item['product_id'],
                    'quantity'        => $item['quantity'],
                    'unit_price'      => $item['unit_price'],
                    'subtotal'        => $item['quantity'] * $item['unit_price'],
                ]);
            }

            DB::commit();

            return response()->json([
                'message' => 'Transfer created successfully and pending Depo approval.',
                'data'    => $sale->load('details.product', 'depo')
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage()
            ], 500);
        }
    }
}
