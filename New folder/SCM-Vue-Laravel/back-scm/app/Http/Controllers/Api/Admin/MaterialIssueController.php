<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\MaterialIssue;
use App\Models\RawMaterial;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MaterialIssueController extends Controller
{
    // ১. ড্রপডাউনের জন্য মেটেরিয়াল লিস্ট পাঠানো
    public function getFormData()
    {
        $materials = RawMaterial::select('id', 'name')->get();
        return response()->json([
            'materials' => $materials
        ]);
    }

    // ২. নতুন ইস্যু সেভ করা
    public function store(Request $request)
    {
        $request->validate([
            'issue_date' => 'required|date',
            'items' => 'required|array|min:1',
            'items.*.raw_material_id' => 'required|exists:raw_materials,id',
            'items.*.quantity' => 'required|numeric|min:0.01',
        ]);

        try {
            return DB::transaction(function () use ($request) {
                // অটোমেটিক ইস্যু নাম্বার জেনারেট করা
                $issueNumber = 'ISS-' . date('Ymd') . '-' . rand(100, 999);

                $issue = MaterialIssue::create([
                    'issue_number' => $issueNumber,
                    'issue_date'   => $request->issue_date,
                    'note'         => $request->note,
                ]);

                foreach ($request->items as $item) {
                    $issue->items()->create([
                        'raw_material_id' => $item['raw_material_id'],
                        'quantity'        => $item['quantity'],
                        'batch_no'        => $item['batch_no'],
                    ]);
                    
                    // এখানে আপনি চাইলে RawMaterial এর stock কমানোর লজিক লিখতে পারেন
                }

                return response()->json(['message' => 'Material issued successfully!'], 201);
            });
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    // ৩. লিস্ট ভিউ করা
    public function index()
    {
        return MaterialIssue::orderBy('issue_date', 'desc')->get();
    }

    // ৪. সিঙ্গেল ডাটা ভিউ (ইনভয়েসের জন্য)
    public function show($id)
    {
        return MaterialIssue::with('items.raw_material')->findOrFail($id);
    }
}