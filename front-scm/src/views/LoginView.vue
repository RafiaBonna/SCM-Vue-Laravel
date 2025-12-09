<template>
  <div class="login-page">
    <div class="login-box">
      <div class="card card-outline card-primary">
        <div class="card-header text-center">
          <a href="#" class="h1"><b>SCM</b> System</a>
        </div>
        <div class="card-body">
          <p class="login-box-msg">Sign in to start your session</p>
          
          <div v-if="error" class="alert alert-danger">{{ error }}</div>
          
          <div v-if="validationErrors" class="alert alert-warning">
            <ul class="mb-0">
              <li v-for="(messages, field) in validationErrors" :key="field">
                <strong>{{ field }}:</strong> {{ messages[0] }}
              </li>
            </ul>
          </div>


          <form @submit.prevent="handleLogin">
            <div class="input-group mb-3">
              <input 
                type="email" 
                class="form-control" 
                placeholder="Email (e.g. distributor@scm.com)" 
                v-model="loginData.email" 
                required
              >
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-envelope"></span>
                </div>
              </div>
            </div>

            <div class="input-group mb-3">
              <input 
                type="password" 
                class="form-control" 
                placeholder="Password" 
                v-model="loginData.password" 
                required
              >
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-lock"></span>
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-4 offset-8">
                <button type="submit" class="btn btn-primary btn-block" :disabled="loading">
                  <span v-if="loading" class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                  Sign In
                </button>
              </div>
            </div>
          </form>
          
          <p class="mb-1 mt-3">
            <a href="#">I forgot my password</a>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import router from '../router'; 

export default {
  name: 'LoginView',
  data() {
    return {
      loginData: {
        email: 'distributor@scm.com', 
        password: 'password'   
      },
      error: null,
      loading: false, 
      validationErrors: null, // ✅ ভ্যালিডেশন এরর স্টোর করার জন্য নতুন ডেটা
    }
  },
  methods: {
    async handleLogin() {
      this.loading = true; 
      this.error = null;
      this.validationErrors = null; // ✅ নতুন রিকোয়েস্টের আগে এরর রিসেট করা
      
      try {
        const response = await axios.post('login', this.loginData);
        
        if (response.data.token) {
          const role = response.data.user.role; 
          
          localStorage.setItem('auth_token', response.data.token);
          localStorage.setItem('user_role', role.toLowerCase()); 
          
          let redirectRoute = ''; 
          if (role === 'admin') {
            redirectRoute = 'admin-dashboard';
          } else if (role === 'depo') {
            redirectRoute = 'depo-dashboard';
          } else if (role === 'distributor') {
            redirectRoute = 'distributor-dashboard';
          } 

          if (redirectRoute) {
            router.push({ name: redirectRoute }); 
          } 
        }

      } catch (err) {
        if (err.response) {
            if (err.response.status === 422) { // ✅ 422 এরর হ্যান্ডলিং
                this.validationErrors = err.response.data.errors;
                this.error = "Validation Failed. Check the fields above.";
            }
            else if (err.response.status === 401) {
                this.error = "Invalid email or password.";
            } else {
                this.error = `Error: ${err.response.data.message || 'Login failed.'}`;
            }
        }
        else {
          this.error = "Cannot connect to the server. Check your backend API (http://localhost:8000).";
        }

      } finally {
        this.loading = false; 
      }
    }
  }
}
</script>

<style scoped>
.login-page {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #e9ecef;
}
</style>