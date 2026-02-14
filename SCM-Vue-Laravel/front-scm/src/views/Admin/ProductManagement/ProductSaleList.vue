<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm">
      <div class="card-header bg-lavender text-indigo d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Product Sale / Transfer List</h5>
        <router-link :to="{ name: 'product-sale-create' }" class="btn btn-sm btn-indigo text-white">
          <i class="fas fa-plus mr-1"></i> New Sale
        </router-link>
      </div>

      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-hover table-bordered">
            <thead class="bg-light text-center">
              <tr>
                <th>Date</th>
                <th>Invoice No</th>
                <th>Depo Name</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="sale in sales" :key="sale.id" class="text-center">
                <td>{{ sale.sale_date }}</td>
                <td><strong>{{ sale.invoice_no }}</strong></td>
                <td>{{ sale.depo?.name || 'N/A' }}</td>
                <td>{{ sale.total_amount }}</td>
                <td>
                  <span :class="statusBadge(sale.status)">
                    {{ sale.status ? sale.status.toUpperCase() : 'PENDING' }}
                  </span>
                </td>
                <td class="text-center">
                 <router-link 
    :to="{ name: 'admin-receive-invoice', params: { id: sale.id } }" 
    class="btn btn-sm btn-outline-info"
>
    <i class="fas fa-eye"></i> View Invoice
</router-link>
                </td>
              </tr>
              <tr v-if="sales.length === 0">
                <td colspan="6" class="text-center text-muted">No sales record found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div v-if="showModal" class="modal-overlay">
        <button @click="showModal = false">Close</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      sales: [],
      showModal: false,
      selectedSale: null
    };
  },
  mounted() {
    this.fetchSales();
  },
  methods: {
    async fetchSales() {
      try {
        /** * গুরুত্বপূর্ণ: 404 এরর সলভ করতে এখানে শুধু 'admin/product-sales' ব্যবহার করুন।
         * যদি Axios baseURL এ আগেই '/api/' থাকে, তবে ডাবল 'api/api' হবে না।
         */
        const response = await axios.get('admin/product-sales');
        
        // ব্যাকএন্ডের return response()->json(['data' => $sales]) অংশটি হ্যান্ডেল করা
        if (response.data && response.data.data) {
          this.sales = response.data.data;
        } else {
          this.sales = response.data;
        }
      } catch (error) {
        console.error("Error fetching sales:", error);
        alert("Could not load sales data. Please check console for errors.");
      }
    },
    viewInvoice(sale) {
      this.selectedSale = sale;
      this.showModal = true;
    },
    statusBadge(status) {
      if (!status) return 'badge badge-secondary';
      const s = status.toLowerCase();
      if (s === 'pending') return 'badge badge-warning text-dark';
      if (s === 'accepted') return 'badge badge-success';
      if (s === 'rejected') return 'badge badge-danger';
      return 'badge badge-info';
    }
  }
};
</script>

<style scoped>
.bg-lavender { background-color: #f2efff; }
.text-indigo { color: #3f2b96; }
.btn-indigo { background-color: #3f2b96; border-color: #3f2b96; }
.badge { padding: 8px 12px; border-radius: 4px; font-weight: 500; }
</style>