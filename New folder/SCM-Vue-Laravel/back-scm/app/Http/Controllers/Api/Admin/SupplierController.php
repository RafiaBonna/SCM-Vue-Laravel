<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Supplier; // ✅ Supplier মডেলটি ইম্পোর্ট করুন
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class SupplierController extends Controller
{
    /**
     * Display a listing of the resource.
     * GET /api/suppliers
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // 10টি Supplier কে paginated আকারে দেখাবে
        $suppliers = Supplier::orderBy('name', 'asc')->paginate(10); 

        return response()->json($suppliers);
    }

    /**
     * Store a newly created resource in storage.
     * POST /api/suppliers
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // 1. Validation
        $request->validate([
            'name' => 'required|string|max:255|unique:suppliers,name', // Supplier নাম ইউনিক হতে হবে
            'contact_person' => 'nullable|string|max:255',
            'email' => 'nullable|email|max:255',
            'phone' => 'nullable|string|max:20',
            'address' => 'nullable|string',
        ]);

        // 2. Create Supplier
        $supplier = Supplier::create($request->all());

        // 3. Return Response
        return response()->json([
            'supplier' => $supplier,
            'message' => 'Supplier added successfully!'
        ], 201); // 201 Created status
    }

    /**
     * Display the specified resource.
     * GET /api/suppliers/{supplier}
     *
     * @param  \App\Models\Supplier  $supplier
     * @return \Illuminate\Http\Response
     */
    public function show(Supplier $supplier)
    {
        // Route Model Binding-এর মাধ্যমে সরাসরি Supplier অবজেক্ট পাওয়া যাবে
        return response()->json($supplier);
    }

    /**
     * Update the specified resource in storage.
     * PUT/PATCH /api/suppliers/{supplier}
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Supplier  $supplier
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Supplier $supplier)
    {
        // 1. Validation (Unique rule-এ বর্তমান Supplier-এর ID বাদ দিয়ে চেক করবে)
        $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
                Rule::unique('suppliers', 'name')->ignore($supplier->id),
            ],
            'contact_person' => 'nullable|string|max:255',
            'email' => 'nullable|email|max:255',
            'phone' => 'nullable|string|max:20',
            'address' => 'nullable|string',
        ]);
        
        // 2. Update Supplier
        $supplier->update($request->all());

        // 3. Return Response
        return response()->json([
            'supplier' => $supplier,
            'message' => 'Supplier updated successfully!'
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     * DELETE /api/suppliers/{supplier}
     *
     * @param  \App\Models\Supplier  $supplier
     * @return \Illuminate\Http\Response
     */
    public function destroy(Supplier $supplier)
    {
        // Delete the supplier record
        $supplier->delete();

        return response()->json([
            'message' => 'Supplier deleted successfully!'
        ], 200);
    }
}