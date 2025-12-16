<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\RawMaterial;
use App\Models\Unit;
use Illuminate\Http\Request;

class RawMaterialController extends Controller
{
    /**
     * কাঁচামালের তালিকা দেখানোর জন্য (Unit Name সহ)
     */
    public function index()
    {
        return RawMaterial::with('unit')->orderBy('name', 'asc')->get();
    }

    /**
     * ড্রপডাউনের জন্য শুধুমাত্র ইউনিটের লিস্ট পাঠানোর জন্য
     */
    public function getFormData()
    {
        return response()->json([
            'units' => Unit::all(['id', 'name']),
        ]);
    }

    /**
     * নতুন Raw Material মাস্টার লিস্টে সেভ করার জন্য
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:255|unique:raw_materials,name',
            'unit_id'     => 'required|exists:units,id',
            'alert_stock' => 'required|numeric|min:0',
            'description' => 'nullable|string',
        ]);

        $rawMaterial = RawMaterial::create($validated);
        
        return response()->json([
            'message' => 'Raw Material added to master list successfully!',
            'data'    => $rawMaterial
        ], 201);
    }

    /**
     * নির্দিষ্ট মেটেরিয়ালের তথ্য দেখার জন্য (Edit করার সময় লাগবে)
     */
    public function show($id)
    {
        $rawMaterial = RawMaterial::findOrFail($id);
        return response()->json($rawMaterial);
    }

    /**
     * মেটেরিয়াল আপডেট করার জন্য
     */
    public function update(Request $request, $id)
    {
        $rawMaterial = RawMaterial::findOrFail($id);

        $validated = $request->validate([
            'name'        => 'required|string|max:255|unique:raw_materials,name,' . $id,
            'unit_id'     => 'required|exists:units,id',
            'alert_stock' => 'required|numeric|min:0',
            'description' => 'nullable|string',
        ]);

        $rawMaterial->update($validated);
        return response()->json(['message' => 'Raw Material updated successfully!']);
    }

    /**
     * মেটেরিয়াল ডিলিট করার জন্য
     */
    public function destroy($id)
    {
        $rawMaterial = RawMaterial::findOrFail($id);
        $rawMaterial->delete();
        return response()->json(['message' => 'Raw Material deleted from master list!']);
    }
}