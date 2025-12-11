// src/views/Admin/UserManagement/UserCreate.vue

<template>
    <div class="container-fluid">
        <div class="content-header">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-info">Create New User</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <router-link :to="{ name: 'admin-dashboard' }">Dashboard</router-link>
                        </li>
                        <li class="breadcrumb-item">
                            <router-link :to="{ name: 'user-list' }">Users</router-link>
                        </li>
                        <li class="breadcrumb-item active">Create</li>
                    </ol>
                </div>
            </div>
        </div>

        <section class="content">
            <div v-if="error" class="alert alert-danger">{{ error }}</div>
            
            <div v-if="validationErrors" class="alert alert-warning">
                <ul class="mb-0">
                    <li v-for="(messages, field) in validationErrors" :key="field">
                        <strong>{{ field }}:</strong> {{ messages[0] }}
                    </li>
                </ul>
            </div>
            
            <div class="card card-outline card-info">
                <div class="card-body">
                    <form @submit.prevent="createUser">
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
                                <label for="password">Password</label>
                                <input type="password" v-model="user.password" class="form-control" id="password" placeholder="Enter password" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="password_confirmation">Confirm Password</label>
                                <input type="password" v-model="user.password_confirmation" class="form-control" id="password_confirmation" placeholder="Confirm password" required>
                            </div>
                        </div>
                        
                        <button type="submit" :disabled="loading" class="btn btn-info mt-3">
                            <span v-if="loading" class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            <span v-else>Create User</span>
                        </button>
                        <router-link :to="{ name: 'user-list' }" class="btn btn-secondary mt-3 ml-2">Cancel</router-link>
                    </form>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: "UserCreate",
    data() {
        return {
            user: {
                name: '',
                email: '',
                role: '',
                password: '', 
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
    methods: {
        async createUser() {
            this.loading = true;
            this.error = null;
            this.validationErrors = null;
            
            try {
                // API কল: POST /api/users
                await axios.post('users', this.user);

                alert('User created successfully!');
                
                // সফল হলে ইউজার লিস্ট পেজে রিডিরেক্ট
                this.$router.push({ name: 'user-list' });

            } catch (err) {
                if (err.response && err.response.status === 422) {
                    this.validationErrors = err.response.data.errors;
                    this.error = 'Validation failed. Please check the form.';
                } else {
                    console.error("Error creating user:", err);
                    this.error = `Creation failed: ${err.response?.data?.message || 'Server error'}`;
                }
            } finally {
                this.loading = false;
            }
        }
    }
}
</script>