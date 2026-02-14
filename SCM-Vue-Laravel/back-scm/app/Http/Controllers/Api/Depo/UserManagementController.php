<?php

namespace App\Http\Controllers\Api\Depo;

use App\Http\Controllers\Controller;
use App\Models\Distributor;
use App\Models\Customer;
use Illuminate\Http\Request;

class UserManagementController extends Controller
{
    // ১. ডিস্ট্রিবিউটর লিস্ট (Axios call: depo/distributors)
    public function getDistributors()
    {
        $distributors = Distributor::where('depo_id', auth()->user()->depo_id)
            ->orderBy('id', 'desc')
            ->get();
        return response()->json($distributors);
    }

    // ২. নতুন ডিস্ট্রিবিউটর স্টোর (Axios call: depo/distributors/store)
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
            'depo_id' => auth()->user()->depo_id,
        ]);

        return response()->json(['success' => true, 'data' => $distributor]);
    }

    // ৩. এডিট করার ডাটা আনা (NEW)
    public function editDistributor($id)
    {
        $distributor = Distributor::where('depo_id', auth()->user()->depo_id)->findOrFail($id);
        return response()->json($distributor);
    }

    // ৪. আপডেট করা (NEW)
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

        return response()->json(['success' => true]);
    }

    // ৫. কাস্টমার লিস্ট
    public function getCustomers()
    {
        $customers = Customer::where('depo_id', auth()->user()->depo_id)->get();
        return response()->json($customers);
    }

    // ৬. নতুন কাস্টমার যোগ করা
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
}
