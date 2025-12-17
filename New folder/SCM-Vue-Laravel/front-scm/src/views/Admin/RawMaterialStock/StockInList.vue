<template>
  <div class="container-fluid mt-4">
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h3 class="card-title">Raw Material Stock In (Invoices)</h3>
        <router-link :to="{ name: 'stock-in-create' }" class="btn btn-primary">
          <i class="fas fa-plus"></i> New Stock In
        </router-link>
      </div>
      <div class="card-body">
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>Date</th>
              <th>Invoice No</th>
              <th>Supplier</th>
              <th>Total Amount</th>
              <th class="text-center">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="invoice in invoices" :key="invoice.id">
              <td>{{ invoice.purchase_date }}</td>
              <td>{{ invoice.po_number }}</td>
              <td>{{ invoice.supplier ? invoice.supplier.name : 'N/A' }}</td>
              <td>{{ invoice.total_amount }}</td>
              <td class="text-center">
                <router-link 
                  :to="{ name: 'stock-in-view', params: { id: invoice.id } }" 
                  class="btn btn-info btn-sm"
                >
                  <i class="fas fa-eye"></i> View Invoice
                </router-link>
              </td>
            </tr>
            <tr v-if="invoices.length === 0">
              <td colspan="5" class="text-center">No invoices found.</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'StockInList',
  data() {
    return {
      invoices: []
    };
  },
  mounted() {
    this.fetchInvoices();
  },
  methods: {
    async fetchInvoices() {
      try {
        // ডুপ্লিকেট /api মুছে দেওয়া হয়েছে
        const response = await axios.get('/admin/purchases'); 
        this.invoices = response.data;
      } catch (error) {
        console.error("Error fetching invoices:", error);
      }
    }
  }
};
</script>