<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Unit; // ✅ Unit মডেলটি use করা হলো
use Illuminate\Http\Request;

class UnitController extends Controller
{
    /**
     * Display a listing of the resource (List).
     * GET /api/admin/units
     */
    public function index()
    {
        // ইউনিটগুলির তালিকা নাম অনুযায়ী সাজিয়ে রিটার্ন করা হচ্ছে
        return Unit::orderBy('name', 'asc')->get();
    }

    /**
     * Store a newly created resource in storage (Create).
     * POST /api/admin/units
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:50|unique:units,name',
            'short_name' => 'required|string|max:10|unique:units,short_name',
        ]);

        $unit = Unit::create($validated);

        return response()->json($unit, 201);
    }

    /**
     * Display the specified resource (Show/Fetch for Edit).
     * GET /api/admin/units/{id}
     */
    public function show(string $id)
    {
        return Unit::findOrFail($id);
    }

    /**
     * Update the specified resource in storage (Update).
     * PATCH/PUT /api/admin/units/{id}
     */
    public function update(Request $request, string $id)
    {
        $unit = Unit::findOrFail($id);

        $validated = $request->validate([
            'name' => [
                'required', 
                'string', 
                'max:50', 
                \Illuminate\Validation\Rule::unique('units', 'name')->ignore($unit->id),
            ],
            'short_name' => [
                'required', 
                'string', 
                'max:10', 
                \Illuminate\Validation\Rule::unique('units', 'short_name')->ignore($unit->id),
            ],
        ]);

        $unit->update($validated);

        return response()->json($unit, 200);
    }

    /**
     * Remove the specified resource from storage (Delete).
     * DELETE /api/admin/units/{id}
     */
    public function destroy(string $id)
    {
        $unit = Unit::findOrFail($id);
        $unit->delete();

        return response()->json(['message' => 'Unit deleted successfully'], 200);
    }
}