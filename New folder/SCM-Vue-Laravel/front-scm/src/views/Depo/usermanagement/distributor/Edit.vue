<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm">
      <div class="card-header bg-info text-white">Edit Distributor</div>
      <div class="card-body">
        <form @submit.prevent="updateDistributor">
          <div class="mb-3">
            <label>Name</label>
            <input v-model="form.name" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Phone</label>
            <input v-model="form.phone" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Email</label>
            <input v-model="form.email" class="form-control">
          </div>
          <div class="mb-3">
            <label>Address</label>
            <textarea v-model="form.address" class="form-control"></textarea>
          </div>
          <button type="submit" class="btn btn-primary" :disabled="loading">
            {{ loading ? 'Updating...' : 'Update' }}
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

// Edit.vue এর স্ক্রিপ্ট অংশ
<script>
import axios from "axios";
export default {
  data() { return { form: { name: '', phone: '', email: '', address: '' }, loading: false } },
  mounted() { this.getDistributorData(); },
  methods: {
    async getDistributorData() {
      try {
        const id = this.$route.params.id;
        // এখানেও /api বাদ দেওয়া হয়েছে
        const response = await axios.get(`depo/distributors/edit/${id}`);
        this.form = response.data;
      } catch (error) {
        alert('Data not found!');
      }
    },
    async updateDistributor() {
      this.loading = true;
      try {
        const id = this.$route.params.id;
        await axios.post(`depo/distributors/update/${id}`, this.form);
        this.$router.push({ name: 'DistributorList' });
      } catch (error) {
        alert('Failed!');
      } finally { this.loading = false; }
    }
  }
}
</script>