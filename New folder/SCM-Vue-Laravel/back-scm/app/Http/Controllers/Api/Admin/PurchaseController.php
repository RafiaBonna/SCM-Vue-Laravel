<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\PurchaseOrder;
use App\Models\PurchaseOrderItem;
use App\Models\RawMaterial;
use App\Models\Supplier;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PurchaseController extends Controller
{
    /**
     * ফর্মের ড্রপডাউন ডেটা (Materials & Suppliers) লোড করার জন্য
     */
    public function getFormData()
    {
        return response()->json([
            'materials' => RawMaterial::all(['id', 'name', 'unit_id']),
            'suppliers' => Supplier::all(['id', 'name'])
        ]);
    }

    /**
     * নতুন স্টক-ইন বা পারচেজ সেভ করার জন্য
     */
    public function store(Request $request)
    {
        $request->validate([
            'invoice_number' => 'required|unique:purchase_orders,po_number',
            'supplier_id'    => 'required|exists:suppliers,id',
            'invoice_date'   => 'required|date',
            'items'          => 'required|array|min:1',
            'items.*.raw_material_id' => 'required|exists:raw_materials,id',
        ]);

        DB::beginTransaction();
        try {
            // ১. মেইন পারচেজ অর্ডার সেভ
            $purchase = PurchaseOrder::create([
                'po_number'     => $request->invoice_number,
                'supplier_id'   => $request->supplier_id,
                'purchase_date' => $request->invoice_date,
                'total_amount'  => $request->grand_total,
                'discount'      => $request->discount ?? 0,
                'note'          => $request->note,
            ]);

            // ২. ডাইনামিক আইটেমগুলো লুপ চালিয়ে সেভ করা
            foreach ($request->items as $item) {
                PurchaseOrderItem::create([
                    'purchase_order_id' => $purchase->id,
                    'raw_material_id'   => $item['raw_material_id'],
                    'batch_no'          => $item['batch_no'],
                    'quantity'          => $item['quantity'],
                    'unit_price'        => $item['unit_price'],
                    'sub_total'         => $item['sub_total'],
                ]);
            }

            DB::commit();
            return response()->json(['message' => 'Stock In successful!'], 201);
            
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json(['error' => 'Failed to save: ' . $e->getMessage()], 500);
        }
    }
}