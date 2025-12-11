<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    // Only these roles can be assigned by admin during create/edit
    protected $editableRoles = ['admin', 'depo', 'distributor']; 

    /**
     * Display a listing of the resource (Users List).
     * GET /api/users
     */
    public function index()
    {
        // Load all users with their roles
        $users = User::with('roles')->orderBy('id', 'desc')->get()->map(function ($user) {
            $role = $user->roles->first();
            return [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                // If no role exists, return 'none'
                'role' => $role ? $role->slug : 'none', 
            ];
        });
        
        return response()->json($users);
    }

    /**
     * Store a newly created resource (Create User).
     * POST /api/users
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users',
            // Only valid roles allowed
            'role' => ['required', 'string', Rule::in($this->editableRoles)], 
            'password' => 'required|string|min:8|confirmed',
        ]);

        DB::beginTransaction();

        try {
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);

            // Find the role and assign it to the user
            $role = Role::where('slug', $request->role)->firstOrFail();
            $user->roles()->attach($role);

            DB::commit();

            return response()->json([
                'message' => 'User created successfully', 
                'user' => $user->load('roles')
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'message' => 'User creation failed.', 
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource (Show User for Edit).
     * GET /api/users/{id}
     */
    public function show(string $id)
    {
        $user = User::with('roles')->findOrFail($id);
        $role = $user->roles->first();

        // Return only required data
        return response()->json([
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'role' => $role ? $role->slug : 'none', 
        ]);
    }

    /**
     * Update the specified resource in storage (Edit User).
     * PATCH /api/users/{id}
     */
    public function update(Request $request, string $id)
    {
        $user = User::findOrFail($id);

        $request->validate([
            'name' => 'required|string|max:255',
            // Unique email check but ignore the current user
            'email' => ['required', 'email', 'max:255', Rule::unique('users')->ignore($user->id)],
            'role' => ['required', 'string', Rule::in($this->editableRoles)], 
            // Password optional
            'password' => 'nullable|string|min:8|confirmed',
        ]);
        
        DB::beginTransaction();

        try {
            $data = $request->only('name', 'email');

            // Update password only if provided
            if ($request->filled('password')) {
                $data['password'] = Hash::make($request->password);
            }

            $user->update($data);

            // Sync new role (remove old and add new)
            $newRole = Role::where('slug', $request->role)->firstOrFail();
            $user->roles()->sync([$newRole->id]);

            DB::commit();

            return response()->json(['message' => 'User updated successfully'], 200);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'message' => 'User update failed.', 
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage (Delete User).
     * DELETE /api/users/{id}
     */
    public function destroy(string $id)
    {
        $user = User::findOrFail($id);
        
        // Prevent deleting your own account
        if (auth()->user()->id == $user->id) {
            return response()->json(['message' => 'You cannot delete your own account.'], 403);
        }

        $user->roles()->detach(); 
        $user->delete();

        return response()->json(['message' => 'User deleted successfully'], 200);
    }
}
