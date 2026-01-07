<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm border-0">
      <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
        <h6 class="mb-0">Distributor List</h6>
        <router-link :to="{ name: 'DistributorCreate' }" class="btn btn-sm btn-primary">
            <i class="fas fa-plus"></i> Add New
        </router-link>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover mb-0">
            <thead>
              <tr>
                <th>SL</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Address</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in distributors" :key="index">
                <td>{{ index + 1 }}</td>
                <td>{{ item.name }}</td>
                <td>{{ item.phone }}</td>
                <td>{{ item.email || 'N/A' }}</td>
                <td>{{ item.address || 'N/A' }}</td>
                <td>
                  <router-link :to="{ name: 'DistributorEdit', params: { id: item.id } }" class="btn btn-sm btn-info text-white">
                    <i class="fas fa-edit"></i> Edit
                  </router-link>
                </td>
              </tr>
              <tr v-if="distributors.length === 0">
                <td colspan="6" class="text-center py-4">No distributors found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

// List.vue এর স্ক্রিপ্ট অংশ
<script>
import axios from "axios";
export default {
  data() { return { distributors: [] } },
  mounted() { this.getDistributors(); },
  methods: {
    async getDistributors() {
      try {
        // ডাবল api/api এরর ঠেকাতে এখানে সরাসরি শুধু পাথ দিন
        const response = await axios.get('/api/depo/distributors')

        this.distributors = response.data;
      } catch (error) {
        console.error("Fetch Error:", error);
      }
    }
  }
}
</script>