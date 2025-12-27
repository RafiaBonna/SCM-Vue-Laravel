<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm">
      <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Product Receive List (From Admin)</h5>
      </div>

      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-hover table-bordered">
            <thead class="bg-light">
              <tr>
                <th>Date</th>
                <th>Invoice No</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in receives" :key="item.id">
                <td>{{ item.sale_date }}</td>
                <td><strong>{{ item.invoice_no }}</strong></td>
                <td>{{ item.total_amount }}</td>
                <td>
                  <span :class="statusBadge(item.status)">
                    {{ item.status.toUpperCase() }}
                  </span>
                </td>
                <td class="text-center">
                  <router-link 
                    :to="{ name: 'depo-receive-invoice', params: { id: item.id } }" 
                    class="btn btn-sm btn-info mr-2"
                  >
                    <i class="fas fa-eye"></i> View Invoice
                  </router-link>

                  <button v-if="item.status === 'pending'" 
                          @click="receiveProduct(item.id)" 
                          class="btn btn-sm btn-success">
                    <i class="fas fa-check-circle mr-1"></i> Receive
                  </button>
                  <span v-else class="badge badge-light border text-muted small ml-1">Received</span>
                </td>
              </tr>
              <tr v-if="receives.length === 0">
                <td colspan="5" class="text-center">No records found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      receives: [],
      loading: false
    };
  },
  mounted() {
    this.fetchReceives();
  },
  methods: {
    async fetchReceives() {
      try {
        // Axios baseURL কনফিগারেশন অনুযায়ী সঠিক পাথ ব্যবহার করা
        const response = await axios.get('/depo/product-receives');
        this.receives = response.data.data;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
    async receiveProduct(id) {
      if (!confirm('Are you sure you have checked the products and want to receive them?')) return;
      
      try {
        // Route prefix 'depo' অনুযায়ী কল করা
        await axios.post(`/depo/product-receives/accept/${id}`);
        alert('Products received successfully! Your stock has been updated.');
        this.fetchReceives();
      } catch (error) {
        alert('Failed to receive products. Please try again.');
      }
    },
    statusBadge(status) {
      if (status === 'pending') return 'badge badge-warning';
      if (status === 'accepted') return 'badge badge-success';
      return 'badge badge-danger';
    }
  }
};
</script>