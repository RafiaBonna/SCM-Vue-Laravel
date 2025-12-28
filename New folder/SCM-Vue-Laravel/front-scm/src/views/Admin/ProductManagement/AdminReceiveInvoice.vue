<template>
  <div class="container py-4">
    <div class="card shadow-sm p-4" v-if="invoice">
      <h3 class="text-center text-primary">TRANSFER INVOICE</h3>
      <hr>
      
      <div class="row mb-4">
        <div class="col-md-6">
          <p><strong>Invoice No:</strong> {{ invoice.invoice_no }}</p>
          <p><strong>Date:</strong> {{ invoice.sale_date }}</p>
        </div>
        <div class="col-md-6 text-right">
          <p><strong>To:</strong> {{ invoice.depo?.name }}</p>
          <p><strong>Status:</strong> 
            <span :class="statusBadge(invoice.status)">{{ invoice.status.toUpperCase() }}</span>
          </p>
        </div>
      </div>

      <table class="table table-bordered">
        <thead class="bg-light">
          <tr>
            <th>Product Name</th>
            <th class="text-center">Quantity</th>
            <th class="text-right">Price</th>
            <th class="text-right">Total</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in invoice.details" :key="item.id">
            <td>{{ item.product?.name }}</td>
            <td class="text-center">{{ item.quantity }}</td>
            <td class="text-right">{{ item.unit_price }}</td>
            <td class="text-right">{{ (item.quantity * item.unit_price).toFixed(2) }}</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <th colspan="3" class="text-right">Grand Total:</th>
            <th class="text-right text-primary">{{ invoice.total_amount }}</th>
          </tr>
        </tfoot>
      </table>

      <div v-if="invoice.status === 'rejected'" class="mt-4 p-3 border border-danger bg-light rounded">
        <h5 class="text-danger font-weight-bold">
          <i class="fas fa-times-circle mr-2"></i> Rejection Details
        </h5>
        <hr class="border-danger">
        <p class="mb-0"><strong>Reject Reason / Note:</strong></p>
        <p class="text-dark bg-white p-2 border rounded shadow-sm">{{ invoice.reject_note || 'No note provided' }}</p>
      </div>

      <div v-if="invoice.note" class="mt-3">
        <p><strong>General Note:</strong> {{ invoice.note }}</p>
      </div>

    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() { return { invoice: null }; },
  mounted() { this.getInvoice(); },
  methods: {
    async getInvoice() {
      const id = this.$route.params.id;
      try {
        const res = await axios.get(`admin/product-sales/${id}`);
        this.invoice = res.data.data;
      } catch (error) {
        console.error("Error loading admin invoice:", error);
      }
    },
    statusBadge(status) {
      if (status === 'pending') return 'badge badge-warning';
      if (status === 'accepted') return 'badge badge-success';
      return 'badge badge-danger';
    }
  }
}
</script>