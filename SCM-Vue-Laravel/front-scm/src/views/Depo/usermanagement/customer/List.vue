<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm border-0">
      <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
        <h6 class="mb-0">Customer List</h6>
        <router-link :to="{ name: 'CustomerCreate' }" class="btn btn-sm btn-light text-success fw-bold">
            <i class="fas fa-plus"></i> Add New Customer
        </router-link>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover mb-0 text-center">
            <thead>
              <tr>
                <th>SL</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in customers" :key="index">
                <td>{{ index + 1 }}</td>
                <td>{{ item.name }}</td>
                <td>{{ item.phone }}</td>
                <td>{{ item.address || 'N/A' }}</td>
                <td>
                  <router-link :to="{ name: 'CustomerEdit', params: { id: item.id } }" class="btn btn-sm btn-warning">
                    <i class="fas fa-edit"></i> Edit
                  </router-link>
                </td>
              </tr>
              <tr v-if="customers.length === 0">
                <td colspan="5" class="py-4">No customers found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() { return { customers: [] } },
  mounted() { this.getCustomers(); },
  methods: {
    async getCustomers() {
      try {
        const response = await axios.get('depo/customers');
        this.customers = response.data;
      } catch (error) {
        console.error("Error fetching customers:", error);
      }
    }
  }
}
</script>