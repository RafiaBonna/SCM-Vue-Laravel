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
     * ১. ডেপোর জন্য আসা চালানের লিস্ট
     */
    public function index()
    {
        $depoId = Auth::user()->depo_id;

        $receives = ProductSale::with('details.product')
            ->where('depo_id', $depoId)
            ->orderBy('id', 'desc')
            ->get();

        return response()->json(['data' => $receives]);
    }

    /**
     * ২. চালান গ্রহণ (Accept) + স্টক আপডেট
     */
    public function acceptTransfer($id)
    {
        try {
            DB::beginTransaction();

            $sale = ProductSale::with('details')->findOrFail($id);

            // Already processed check
            if ($sale->status !== 'pending') {
                return response()->json([
                    'message' => 'This transfer is already ' . $sale->status
                ], 400);
            }

            // Sale status update
            $sale->status = 'accepted';
            $sale->save();

            foreach ($sale->details as $item) {

                /**
                 * ================= ADMIN STOCK UPDATE =================
                 */
                $adminStock = AdminStock::where('product_id', $item->product_id)->first();

                if (!$adminStock) {
                    throw new \Exception(
                        'Admin stock not found for product ID: ' . $item->product_id
                    );
                }

                if ($adminStock->current_stock < $item->quantity) {
                    throw new \Exception(
                        'Insufficient admin stock for product ID: ' . $item->product_id
                    );
                }

                $adminStock->sales_qty += $item->quantity;
                $adminStock->current_stock -= $item->quantity;
                $adminStock->save();

                /**
                 * ================= DEPO STOCK UPDATE =================
                 */
                $depoStock = DepoStock::firstOrNew([
                    'depo_id'    => $sale->depo_id,
                    'product_id' => $item->product_id,
                ]);

                // New record হলে default value set
                if (!$depoStock->exists) {
                    $depoStock->opening_stock = 0;
                    $depoStock->received_qty  = 0;
                    $depoStock->current_stock = 0;
                }

                $depoStock->received_qty  += $item->quantity;
                $depoStock->current_stock += $item->quantity;
                $depoStock->save();
            }

            DB::commit();

            return response()->json([
                'message' => 'Product received successfully! Stock updated.'
            ]);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * ৩. ডেপোর বর্তমান স্টক লিস্ট
     */
public function currentStock()
{
    $depoId = auth()->user()->depo_id;

    $stocks = DepoStock::with('product')
        ->where('depo_id', $depoId)
        ->get();

    return response()->json([
        'success' => true,
        'data' => $stocks
    ]);
}
 public function viewInvoice($id)
{
    try {
        // রিলেশনশিপের নামগুলো আপনার মডেল অনুযায়ী ঠিক আছে কি না চেক করুন
        $invoice = ProductSale::with(['details.product', 'depo'])->find($id);

        if (!$invoice) {
            return response()->json(['status' => 'error', 'message' => 'Invoice not found'], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $invoice
        ]);
    } catch (\Exception $e) {
        // ৫00 এরর কেন আসছে তা জানার জন্য লারাভেল লগ ফাইল (storage/logs/laravel.log) দেখুন
        return response()->json([
            'status' => 'error', 
            'message' => $e->getMessage()
        ], 500);
    }
}
}
