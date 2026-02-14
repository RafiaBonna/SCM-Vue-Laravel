<template>
  <div class="container-fluid py-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-success text-white">
            <h6 class="mb-0">Add New Customer</h6>
          </div>
          <div class="card-body">
            <form @submit.prevent="saveCustomer">
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label for="customer_name" class="form-label">Customer Name *</label>
                  <input v-model="form.name" type="text" id="customer_name" name="name" class="form-control" required placeholder="Enter customer name">
                </div>
                <div class="col-md-6 mb-3">
                  <label for="customer_phone" class="form-label">Phone Number *</label>
                  <input v-model="form.phone" type="text" id="customer_phone" name="phone" class="form-control" required placeholder="Enter phone number">
                </div>
                <div class="col-md-12 mb-3">
                  <label for="customer_address" class="form-label">Address</label>
                  <textarea v-model="form.address" id="customer_address" name="address" class="form-control" rows="3" placeholder="Enter full address"></textarea>
                </div>
              </div>
              <div class="text-end mt-3">
                <button type="submit" class="btn btn-success px-4" :disabled="loading">
                  {{ loading ? 'Saving...' : 'Save Customer' }}
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
  data() { return { form: { name: '', phone: '', address: '' }, loading: false } },
  methods: {
    async saveCustomer() {
      this.loading = true;
      try {
        await axios.post('depo/customers/store', this.form);
        alert('Customer Created Successfully!');
        this.$router.push({ name: 'CustomerList' });
      } catch (error) {
        alert('Failed to save customer');
      } finally { this.loading = false; }
    }
  }
}
</script>