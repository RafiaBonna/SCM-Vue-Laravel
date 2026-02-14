<template>
  <div class="container-fluid py-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm border-0">
          <div class="card-header bg-info text-white">
            <h6 class="mb-0">Edit Distributor</h6>
          </div>
          <div class="card-body">
            <form @submit.prevent="updateDistributor">
              <div class="mb-3">
                <label for="edit_name">Name</label>
                <input v-model="form.name" id="edit_name" name="name" class="form-control" required>
              </div>
              <div class="mb-3">
                <label for="edit_phone">Phone</label>
                <input v-model="form.phone" id="edit_phone" name="phone" class="form-control" required>
              </div>
              <div class="mb-3">
                <label for="edit_email">Email</label>
                <input v-model="form.email" id="edit_email" name="email" class="form-control">
              </div>
              <div class="mb-3">
                <label for="edit_address">Address</label>
                <textarea v-model="form.address" id="edit_address" name="address" class="form-control"></textarea>
              </div>
              <button type="submit" class="btn btn-primary" :disabled="loading">
                {{ loading ? 'Updating...' : 'Update' }}
              </button>
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
  mounted() { this.getDistributorData(); },
  methods: {
    async getDistributorData() {
      try {
        const response = await axios.get(`depo/distributors/edit/${this.$route.params.id}`);
        this.form = response.data;
      } catch (error) {
        alert('Data not found!');
      }
    },
    async updateDistributor() {
      this.loading = true;
      try {
        await axios.post(`depo/distributors/update/${this.$route.params.id}`, this.form);
        alert('Updated!');
        this.$router.push({ name: 'DistributorList' });
      } catch (error) {
        alert('Failed to update');
      } finally { this.loading = false; }
    }
  }
}
</script>