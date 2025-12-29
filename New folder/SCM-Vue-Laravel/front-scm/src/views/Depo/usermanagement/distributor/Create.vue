<template>
  <div class="container-fluid py-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h6 class="mb-0">Add New Distributor</h6>
            <router-link to="/depo/distributors" class="btn btn-sm btn-light">
              <i class="fas fa-list"></i> Back to List
            </router-link>
          </div>
          <div class="card-body">
            <form @submit.prevent="saveDistributor">
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label class="form-label">Full Name <span class="text-danger">*</span></label>
                  <input v-model="form.name" type="text" class="form-control" required placeholder="Enter name">
                </div>
                
                <div class="col-md-6 mb-3">
                  <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                  <input v-model="form.phone" type="text" class="form-control" required placeholder="Enter phone">
                </div>

                <div class="col-md-12 mb-3">
                  <label class="form-label">Email (Optional)</label>
                  <input v-model="form.email" type="email" class="form-control" placeholder="Enter email">
                </div>

                <div class="col-md-12 mb-3">
                  <label class="form-label">Address</label>
                  <textarea v-model="form.address" class="form-control" rows="3" placeholder="Enter full address"></textarea>
                </div>
              </div>

              <div class="text-end">
                <button type="submit" class="btn btn-primary px-4" :disabled="loading">
                  <i class="fas fa-save me-1"></i> {{ loading ? 'Saving...' : 'Save Distributor' }}
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        name: '',
        phone: '',
        email: '',
        address: ''
      },
      loading: false
    }
  },
  methods: {
    async saveDistributor() {
      this.loading = true;
      try {
        const response = await axios.post('/api/depo/distributors/store', this.form);
        if (response.data.success) {
          alert('Distributor created successfully!');
          this.$router.push('/depo/distributors'); // সেভ হওয়ার পর লিস্ট পেজে চলে যাবে
        }
      } catch (error) {
        if (error.response && error.response.status === 422) {
            alert('Validation Error: Please check your inputs.');
        } else {
            alert('Something went wrong!');
        }
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>