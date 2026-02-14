<template>
  <div class="container-fluid py-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-primary text-white">
            <h6 class="mb-0">Add New Distributor</h6>
          </div>
          <div class="card-body">
            <form @submit.prevent="saveDistributor">
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label for="name" class="form-label">Full Name *</label>
                  <input v-model="form.name" type="text" id="name" name="name" class="form-control" required placeholder="Enter name">
                </div>
                <div class="col-md-6 mb-3">
                  <label for="phone" class="form-label">Phone Number *</label>
                  <input v-model="form.phone" type="text" id="phone" name="phone" class="form-control" required placeholder="Enter phone">
                </div>
                <div class="col-md-12 mb-3">
                  <label for="email" class="form-label">Email</label>
                  <input v-model="form.email" type="email" id="email" name="email" class="form-control" placeholder="Enter email">
                </div>
                <div class="col-md-12 mb-3">
                  <label for="address" class="form-label">Address</label>
                  <textarea v-model="form.address" id="address" name="address" class="form-control" rows="3"></textarea>
                </div>
              </div>
              <div class="text-end mt-3">
                <button type="submit" class="btn btn-primary px-4" :disabled="loading">
                  {{ loading ? 'Saving...' : 'Save Distributor' }}
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
import axios from "axios";
export default {
  data() { return { form: { name: '', phone: '', email: '', address: '' }, loading: false } },
  methods: {
    async saveDistributor() {
      this.loading = true;
      try {
        await axios.post('depo/distributors/store', this.form);
        alert('Created Successfully!');
        this.$router.push({ name: 'DistributorList' });
      } catch (error) {
        alert('Something went wrong!');
      } finally { this.loading = false; }
    }
  }
}
</script>