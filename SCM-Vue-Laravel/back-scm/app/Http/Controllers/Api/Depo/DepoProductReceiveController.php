<?php

namespace App\Http\Controllers\Api\Depo;

use App\Http\Controllers\Controller;
use App\Models\ProductSale;
use App\Models\DepoStock;
use App\Models\AdminStock;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class DepoProductReceiveController extends Controller
{
    /**
     * 1️⃣ Depo incoming transfer list
     */
   public function index()
{
    $user = Auth::user();
    // লগিন করা ইউজারের ড্যাপো আইডি অনুযায়ী ডাটা আনা
    $receives = ProductSale::with(['details.product', 'depo'])
        ->where('depo_id', $user->depo_id) 
        ->orderBy('id', 'desc')
        ->get();

    return response()->json([
        'success' => true,
        'data' => $receives
    ]);
}

    /**
     * 2️⃣ Accept transfer + stock update
     */
   public function acceptTransfer($id)
{
    try {
        DB::beginTransaction();

        $sale = ProductSale::with('details')->findOrFail($id);

        if ($sale->status !== 'pending') {
            return response()->json(['message' => 'Already processed'], 400);
        }

        // ১. সেলের স্ট্যাটাস আপডেট
        $sale->status = 'accepted';
        $sale->save();

        foreach ($sale->details as $item) {
            
            // --- এইখানে কোডটি থাকবে ---
            // ২. অ্যাডমিন স্টক থেকে মাল কমানো
            $adminStock = AdminStock::where('product_id', $item->product_id)->first();
            if ($adminStock) {
                $adminStock->decrement('current_stock', $item->quantity);
            }

            // ৩. ড্যাপোর স্টকে মাল বাড়ানো (আপনার আগের কোড অনুযায়ী)
            $depoStock = DepoStock::firstOrCreate(
                ['depo_id' => $sale->depo_id, 'product_id' => $item->product_id],
                ['current_stock' => 0]
            );
            $depoStock->increment('current_stock', $item->quantity);
            $depoStock->increment('received_qty', $item->quantity);
        }

        DB::commit();
        return response()->json(['success' => true, 'message' => 'Received successfully']);

    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json(['message' => $e->getMessage()], 500);
    }
}

    /**
     * 3️⃣ Reject transfer with note
     */
    public function rejectTransfer(Request $request, $id)
{
    $request->validate(['reject_note' => 'required|string']);

    try {
        $receive = \App\Models\ProductSale::findOrFail($id); 
        $receive->status = 'rejected';
        // নিশ্চিত করুন ডাটা 'reject_note' কলামে যাচ্ছে, 'note' এ নয়
        $receive->reject_note = $request->reject_note; 
        $receive->save();

        return response()->json(['status' => 'success', 'message' => 'Rejected successfully']);
    } catch (\Exception $e) {
        return response()->json(['status' => 'error', 'message' => $e->getMessage()], 500);
    }
}

    /**
     * 4️⃣ Depo current stock list
     */
    public function currentStock()
    {
        $depoId = Auth::user()->depo_id;

        $stocks = DepoStock::with('product')
            ->where('depo_id', $depoId)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $stocks
        ]);
    }

    /**
     * 5️⃣ View invoice
     */
    public function viewInvoice($id)
    {
        try {
            $invoice = ProductSale::with(['details.product', 'depo'])
                ->find($id);

            if (!$invoice) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invoice not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $invoice
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
