<?php

namespace App\Http\Controllers\Api\Depo;

use App\Http\Controllers\Controller;
use App\Models\DepoSale;
use App\Models\DepoSaleDetail;
use App\Models\DepoStock;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DepoSaleController extends Controller
{
    public function store(Request $request)
    {
        // ১. ভ্যালিডেশন
        $request->validate([
            'sale_type' => 'required|in:distributor,customer',
            'sale_to_id' => 'required',
            'items' => 'required|array',
            'sale_date' => 'required|date',
        ]);

        DB::beginTransaction();
        try {
            // ২. স্ট্যাটাস নির্ধারণ (আপনার শর্ত অনুযায়ী)
            // কাস্টমার হলে 'accepted', ডিস্ট্রিবিউটর হলে 'pending'
            $status = ($request->sale_type === 'customer') ? 'accepted' : 'pending';

            // ৩. মেইন সেলস ডাটা সেভ
            $sale = DepoSale::create([
                'invoice_no' => 'DS-' . strtoupper(uniqid()),
                'sale_date' => $request->sale_date,
                'depo_id' => auth()->user()->depo_id,
                'sale_type' => $request->sale_type,
                'sale_to_id' => $request->sale_to_id,
                'total_amount' => $request->total_amount,
                'status' => $status,
                'note' => $request->note,
            ]);

            // ৪. প্রোডাক্ট ডিটেইলস সেভ এবং স্টক আপডেট (যদি কাস্টমার হয়)
            foreach ($request->items as $item) {
                DepoSaleDetail::create([
                    'depo_sale_id' => $sale->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'subtotal' => $item['quantity'] * $item['unit_price'],
                ]);

                // যদি কাস্টমার সেল হয়, তবে ড্যাপোর স্টক থেকে তখনি মাল কমিয়ে দিন
                if ($status === 'accepted') {
                    $stock = DepoStock::where('depo_id', auth()->user()->depo_id)
                        ->where('product_id', $item['product_id'])
                        ->first();
                    
                    if ($stock) {
                        $stock->decrement('current_stock', $item['quantity']);
                        $stock->increment('sales_qty', $item['quantity']);
                    }
                }
            }

            DB::commit();
            return response()->json(['success' => true, 'message' => 'Sale processed successfully']);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    // ১. ডিস্ট্রিবিউটর যখন সেলটি একসেপ্ট (Approve) করবে
    public function acceptByDistributor($id)
    {
        DB::beginTransaction();
        try {
            $sale = DepoSale::with('details')->findOrFail($id);

            if ($sale->status !== 'pending') {
                return response()->json(['message' => 'This sale is already processed'], 400);
            }

            // স্ট্যাটাস আপডেট
            $sale->status = 'accepted';
            $sale->save();

            // এখন ড্যাপোর স্টক থেকে মাল কমিয়ে দিন (যেহেতু ডিস্ট্রিবিউটর মাল বুঝে পেয়েছে)
            foreach ($sale->details as $item) {
                $stock = DepoStock::where('depo_id', $sale->depo_id)
                    ->where('product_id', $item->product_id)
                    ->first();

                if ($stock) {
                    $stock->decrement('current_stock', $item->quantity);
                    $stock->increment('sales_qty', $item->quantity);
                }
            }

            DB::commit();
            return response()->json(['success' => true, 'message' => 'Sale accepted and stock updated']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    // ২. ডিস্ট্রিবিউটর যখন সেলটি রিজেক্ট করবে (Reject Note সহ)
    public function rejectByDistributor(Request $request, $id)
    {
        $request->validate([
            'reject_note' => 'required|string|max:500' // কেন রিজেক্ট করছে তা অবশ্যই লিখতে হবে
        ]);

        $sale = DepoSale::findOrFail($id);

        if ($sale->status !== 'pending') {
            return response()->json(['message' => 'This sale cannot be rejected'], 400);
        }

        $sale->status = 'rejected';
        $sale->reject_note = $request->reject_note; // নোটটি সেভ হচ্ছে
        $sale->save();

        return response()->json(['success' => true, 'message' => 'Sale rejected with note']);
    }
}