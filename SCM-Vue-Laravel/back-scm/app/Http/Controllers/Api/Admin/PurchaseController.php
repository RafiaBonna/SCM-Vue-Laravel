<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\PurchaseOrder;
use App\Models\PurchaseOrderItem;
use App\Models\RawMaterial;
use App\Models\RawMaterialStock; // নতুন মডেলটি ইম্পোর্ট করলাম
use App\Models\Supplier;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PurchaseController extends Controller
{
    public function index()
    {
        return PurchaseOrder::with('supplier')->orderBy('id', 'desc')->get();
    }

    public function show($id)
    {
        return PurchaseOrder::with(['supplier', 'items.raw_material'])->findOrFail($id);
    }

    public function getFormData()
    {
        return response()->json([
            'materials' => RawMaterial::all(['id', 'name']),
            'suppliers' => Supplier::all(['id', 'name'])
        ]);
    }

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
            // ১. মেইন পারচেজ অর্ডার সেভ করা
            $purchase = PurchaseOrder::create([
                'po_number'     => $request->invoice_number,
                'supplier_id'   => $request->supplier_id,
                'purchase_date' => $request->invoice_date,
                'total_amount'  => $request->grand_total,
                'discount'      => $request->discount ?? 0,
                'note'          => $request->note,
            ]);

            // ২. আইটেমগুলো লুপ চালিয়ে সেভ করা এবং স্টক লেজারে এন্ট্রি দেওয়া
            foreach ($request->items as $item) {
                // ২.১ পারচেজ আইটেম টেবিল সেভ
                PurchaseOrderItem::create([
                    'purchase_order_id' => $purchase->id,
                    'raw_material_id'   => $item['raw_material_id'],
                    'batch_no'          => $item['batch_no'],
                    'quantity'          => $item['quantity'],
                    'unit_price'        => $item['unit_price'],
                    'sub_total'         => $item['sub_total'],
                ]);

                // ২.২ আলাদা স্টক হিস্ট্রি টেবিল (RawMaterialStock) এ এন্ট্রি দেওয়া ✅
                RawMaterialStock::create([
                    'raw_material_id' => $item['raw_material_id'],
                    'quantity'        => $item['quantity'],
                    'type'            => 'in', // যেহেতু মাল ঢুকছে
                    'reference_id'    => $purchase->id, // পারচেজ অর্ডারের আইডি
                    'note'            => 'Stock In from Invoice: ' . $purchase->po_number,
                ]);
            }

            DB::commit();
            return response()->json(['message' => 'Stock In successful & Ledger Updated!', 'id' => $purchase->id], 201);
            
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json(['error' => 'Failed to save: ' . $e->getMessage()], 500);
        }
    }
}