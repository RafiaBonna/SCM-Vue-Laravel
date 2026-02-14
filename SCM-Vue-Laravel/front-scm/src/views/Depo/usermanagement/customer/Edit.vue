<template>
  <div class="container-fluid py-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-warning text-dark">
            <h6 class="mb-0">Edit Customer</h6>
          </div>
          <div class="card-body">
            <form @submit.prevent="updateCustomer">
              <div class="mb-3">
                <label for="edit_cust_name" class="form-label">Name</label>
                <input v-model="form.name" id="edit_cust_name" name="name" class="form-control" required>
              </div>
              <div class="mb-3">
                <label for="edit_cust_phone" class="form-label">Phone</label>
                <input v-model="form.phone" id="edit_cust_phone" name="phone" class="form-control" required>
              </div>
              <div class="mb-3">
                <label for="edit_cust_address" class="form-label">Address</label>
                <textarea v-model="form.address" id="edit_cust_address" name="address" class="form-control" rows="3"></textarea>
              </div>
              <div class="text-end">
                <button type="submit" class="btn btn-primary" :disabled="loading">
                  {{ loading ? 'Updating...' : 'Update Customer' }}
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
  mounted() { this.getCustomerData(); },
  methods: {
    async getCustomerData() {
      try {
        const id = this.$route.params.id;
        const response = await axios.get(`depo/customers/edit/${id}`);
        this.form = response.data;
      } catch (error) {
        alert('Customer data not found!');
      }
    },
    async updateCustomer() {
      this.loading = true;
      try {
        const id = this.$route.params.id;
        await axios.post(`depo/customers/update/${id}`, this.form);
        alert('Customer Updated!');
        this.$router.push({ name: 'CustomerList' });
      } catch (error) {
        alert('Update failed');
      } finally { this.loading = false; }
    }
  }
}
</script>