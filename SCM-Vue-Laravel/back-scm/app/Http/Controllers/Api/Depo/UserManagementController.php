<?php

namespace App\Http\Controllers\Api\Depo;

use App\Http\Controllers\Controller;
use App\Models\Distributor;
use App\Models\Customer;
use Illuminate\Http\Request;

class UserManagementController extends Controller
{
    // ১. ডিস্ট্রিবিউটর লিস্ট (শুধুমাত্র নিজের ডেপোর)
    public function getDistributors()
    {
        $distributors = Distributor::where('depo_id', auth()->user()->depo_id)->get();
        return response()->json($distributors);
    }

    // ২. নতুন ডিস্ট্রিবিউটর যোগ করা
    public function storeDistributor(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
        ]);

        $distributor = Distributor::create([
            'name' => $request->name,
            'phone' => $request->phone,
            'email' => $request->email,
            'address' => $request->address,
            'depo_id' => auth()->user()->depo_id, // অটোমেটিক নিজের ডেপো আইডি বসবে
        ]);

        return response()->json(['success' => true, 'data' => $distributor]);
    }

    // --- NEW METHODS ADDED FOR UPDATE ---

    public function editDistributor($id)
    {
        // Shudhu nijer depo-r distributor kina check kore data ana
        $distributor = Distributor::where('depo_id', auth()->user()->depo_id)->findOrFail($id);
        return response()->json($distributor);
    }

    public function updateDistributor(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
        ]);

        $distributor = Distributor::where('depo_id', auth()->user()->depo_id)->findOrFail($id);

        $distributor->update([
            'name' => $request->name,
            'phone' => $request->phone,
            'email' => $request->email,
            'address' => $request->address,
        ]);

        return response()->json(['success' => true, 'message' => 'Distributor Updated']);
    }

    // --- END OF NEW METHODS ---

    // ৩. কাস্টমার লিস্ট (শুধুমাত্র নিজের ডেপোর)
    public function getCustomers()
    {
        $customers = Customer::where('depo_id', auth()->user()->depo_id)->get();
        return response()->json($customers);
    }

    // ৪. নতুন কাস্টমার যোগ করা
    public function storeCustomer(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
        ]);

        $customer = Customer::create([
            'name' => $request->name,
            'phone' => $request->phone,
            'address' => $request->address,
            'depo_id' => auth()->user()->depo_id,
        ]);

        return response()->json(['success' => true, 'data' => $customer]);
    }

    // ডিস্ট্রিবিউটরদের লিস্ট (Pagination সহ)
    public function indexDistributor()
    {
        $distributors = Distributor::where('depo_id', auth()->user()->depo_id)
            ->orderBy('id', 'desc')
            ->paginate(10);
        return response()->json($distributors);
    }

    // কাস্টমারদের লিস্ট (Pagination সহ)
    public function indexCustomer()
    {
        $customers = Customer::where('depo_id', auth()->user()->depo_id)
            ->orderBy('id', 'desc')
            ->paginate(10);
        return response()->json($customers);
    }
}
