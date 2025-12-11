// src/views/Admin/UserManagement/UserEdit.vue

<template>
    <div class="container-fluid">
        <div class="content-header">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-info">Edit User ID: {{ $route.params.id }}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <router-link :to="{ name: 'admin-dashboard' }">Dashboard</router-link>
                        </li>
                        <li class="breadcrumb-item">
                            <router-link :to="{ name: 'user-list' }">Users</router-link>
                        </li>
                        <li class="breadcrumb-item active">Edit</li>
                    </ol>
                </div>
            </div>
        </div>

        <section class="content">
            <div v-if="loading && !user.id" class="text-center text-primary">Loading user data...</div>
            
            <div v-if="error" class="alert alert-danger">{{ error }}</div>
            
            <div v-if="validationErrors" class="alert alert-warning">
                <ul class="mb-0">
                    <li v-for="(messages, field) in validationErrors" :key="field">
                        <strong>{{ field }}:</strong> {{ messages[0] }}
                    </li>
                </ul>
            </div>
            
            <div class="card card-outline card-info" v-if="!loading || user.id">
                <div class="card-body">
                    <form @submit.prevent="updateUser">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" v-model="user.name" class="form-control" id="name" placeholder="Enter full name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" v-model="user.email" class="form-control" id="email" placeholder="Enter email" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="role">Role</label>
                            <select v-model="user.role" class="form-control" id="role" required>
                                <option value="" disabled>Select Role</option>
                                <option v-for="role in roles" :key="role.value" :value="role.value">{{ role.name }}</option>
                            </select>
                        </div>
                        
                        <hr>
                        
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="password">New Password (Optional)</label>
                                <input type="password" v-model="user.password" class="form-control" id="password" placeholder="Enter new password">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="password_confirmation">Confirm Password</label>
                                <input type="password" v-model="user.password_confirmation" class="form-control" id="password_confirmation" placeholder="Confirm new password">
                            </div>
                        </div>
                        
                        <button type="submit" :disabled="loading" class="btn btn-info mt-3">
                            <span v-if="loading" class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            <span v-else>Update User</span>
                        </button>
                        <router-link :to="{ name: 'user-list' }" class="btn btn-secondary mt-3 ml-2">Back to List</router-link>
                    </form>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: "UserEdit",
    data() {
        return {
            user: {
                id: null,
                name: '',
                email: '',
                role: '',
                password: '', // এই ফিল্ডটি খালি থাকলেও আপডেট করা হবে না
                password_confirmation: '',
            },
            roles: [
                { value: 'admin', name: 'Admin' }, 
                { value: 'depo', name: 'Depo' },
                { value: 'distributor', name: 'Distributor' },
            ],
            validationErrors: null,
            error: null,
            loading: false,
        };
    },
    // কম্পোনেন্ট তৈরি হওয়ার আগে ইউজার আইডি প্যারামিটার থেকে নেওয়া
    created() {
        this.user.id = this.$route.params.id;
        this.fetchUser();
    },
    methods: {
        async fetchUser() {
            this.loading = true;
            this.error = null;
            try {
                // API কল: GET /api/users/{id}
                const response = await axios.get(`users/${this.user.id}`);
                
                // প্রাপ্ত ডেটা ফর্মে সেট করা
                this.user.name = response.data.name;
                this.user.email = response.data.email;
                this.user.role = response.data.role;

            } catch (err) {
                console.error("Error fetching user:", err);
                this.error = 'Failed to load user data. User may not exist or access denied.';
                this.$router.push({ name: 'user-list' }); // ডেটা না পেলে লিস্টে ফিরে যাওয়া
            } finally {
                this.loading = false;
            }
        },
        async updateUser() {
            this.loading = true;
            this.error = null;
            this.validationErrors = null;

            // পাসওয়ার্ড ফিল্ড খালি হলে, আপডেট ডেটা থেকে বাদ দেওয়া 
            const formData = {
                name: this.user.name,
                email: this.user.email,
                role: this.user.role,
                ...(this.user.password && { // পাসওয়ার্ড ফিল্ড পূর্ণ থাকলে তবেই যোগ করা
                    password: this.user.password,
                    password_confirmation: this.user.password_confirmation 
                })
            };

            try {
                // API কল: PATCH /api/users/{id}
                await axios.patch(`users/${this.user.id}`, formData);

                alert('User updated successfully!');
                
                this.$router.push({ name: 'user-list' });

            } catch (err) {
                if (err.response && err.response.status === 422) {
                    this.validationErrors = err.response.data.errors;
                    this.error = 'Validation failed. Please check the form.';
                } else {
                    console.error("Error updating user:", err);
                    this.error = `Update failed: ${err.response?.data?.message || 'Server error'}`;
                }
            } finally {
                this.loading = false;
            }
        }
    }
}
</script>