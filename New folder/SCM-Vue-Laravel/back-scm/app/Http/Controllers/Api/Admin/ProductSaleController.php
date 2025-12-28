<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\ProductSale;
use App\Models\ProductSaleDetail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductSaleController extends Controller
{
    // ১. সব সেলস/ট্রান্সফার লিস্ট দেখা
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

    // ২. নতুন সেলস/ট্রান্সফার এন্ট্রি করা
    public function store(Request $request)
    {
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

            $invoiceNo = 'INV-' . time() . rand(10, 99);

            $sale = ProductSale::create([
                'invoice_no'   => $invoiceNo,
                'sale_date'    => $request->sale_date,
                'depo_id'      => $request->depo_id,
                'total_amount' => $request->total_amount,
                'status'       => 'pending',
                'note'         => $request->note ?? null,
            ]);

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
                'message' => 'Transfer created successfully.',
                'data'    => $sale->load('details.product', 'depo')
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Error: ' . $e->getMessage()], 500);
        }
    }

    // ৩. নির্দিষ্ট একটি সেলস ডাটা দেখা (আপনার চাওয়া আপডেট)
   public function show($id)
{
    try {
        // details.product ebong depo soho data ana hochche
        $sale = ProductSale::with(['details.product', 'depo'])->findOrFail($id);
        
        return response()->json([
            'success' => true,
            'data' => $sale // Ekhane automatic reject_note thakbe jodi table-e thake
        ]);
    } catch (\Exception $e) {
        return response()->json(['message' => 'Error: ' . $e->getMessage()], 500);
    }
}

    // ৪. সেলস ডাটা আপডেট করা
    public function update(Request $request, $id)
    {
        $sale = ProductSale::findOrFail($id);

        $request->validate([
            'depo_id'    => 'required|exists:depos,id',
            'sale_date'  => 'required|date',
            'total_amount' => 'required|numeric|min:0',
            'items'      => 'required|array|min:1',
        ]);

        try {
            DB::beginTransaction();

            // মেইন টেবিল আপডেট
            $sale->update([
                'depo_id'      => $request->depo_id,
                'sale_date'    => $request->sale_date,
                'total_amount' => $request->total_amount,
                'note'         => $request->note ?? $sale->note,
            ]);

            // আগের ডিটেইলস মুছে ফেলে নতুনগুলো সেভ করা (সহজ পদ্ধতি)
            $sale->details()->delete();

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
                'message' => 'Sale updated successfully.',
                'data'    => $sale->load('details.product', 'depo')
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Update failed: ' . $e->getMessage()], 500);
        }
    }

    // ৫. ডিলিট করা
    public function destroy($id)
    {
        $sale = ProductSale::findOrFail($id);
        $sale->details()->delete(); // আগে চাইল্ড ডাটা ডিলিট
        $sale->delete(); // তারপর মেইন ডাটা ডিলিট

        return response()->json(['message' => 'Sale deleted successfully.']);
    }
}