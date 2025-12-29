<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm border-0">
      <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
        <h6 class="mb-0">Distributor List</h6>
        <router-link to="/depo/distributors/create" class="btn btn-sm btn-primary">
          <i class="fas fa-plus"></i> Add New Distributor
        </router-link>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover mb-0">
            <thead class="table-light">
              <tr>
                <th width="80">SL</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Address</th>
                <th width="150">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in distributors" :key="item.id">
                <td>{{ index + 1 }}</td>
                <td>{{ item.name }}</td>
                <td>{{ item.phone }}</td>
                <td>{{ item.email || 'N/A' }}</td>
                <td>{{ item.address || 'N/A' }}</td>
                <td>
                  <router-link :to="`/depo/distributors/edit/${item.id}`" class="btn btn-sm btn-info text-white me-2">
                    <i class="fas fa-edit"></i> Edit
                  </router-link>
                </td>
              </tr>
              <tr v-if="distributors.length === 0">
                <td colspan="6" class="text-center py-4 text-muted">No distributors found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      distributors: [] // এখানে ডাটা জমা হবে
    }
  },
  mounted() {
    this.getDistributors(); // পেজ লোড হলে ডাটা নিয়ে আসবে
  },
  methods: {
    async getDistributors() {
      try {
     
        const response = await axios.get('/api/depo/distributors');
        this.distributors = response.data;
      } catch (error) {
        console.error("Error fetching distributors:", error);
      }
    }
  }
}
</script>