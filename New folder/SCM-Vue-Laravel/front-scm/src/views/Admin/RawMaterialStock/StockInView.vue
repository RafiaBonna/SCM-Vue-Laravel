<template>
  <div class="container-fluid mt-4">
    <div class="card" id="printableArea">
      <div class="card-header d-flex justify-content-between align-items-center no-print">
        <h3 class="card-title">Purchase Invoice Details</h3>
        <div>
          <button @click="printInvoice" class="btn btn-secondary mr-2">
            <i class="fas fa-print"></i> Print
          </button>
          <router-link :to="{ name: 'stock-in-list' }" class="btn btn-primary">
            Back to List
          </router-link>
        </div>
      </div>
      
      <div class="card-body invoice-box">
        <div class="row mb-4">
          <div class="col-sm-6">
            <h5 class="mb-3">Supplier:</h5>
            <div v-if="invoice.supplier">
              <strong>{{ invoice.supplier.name }}</strong><br>
              Phone: {{ invoice.supplier.phone }}<br>
              Address: {{ invoice.supplier.address }}
            </div>
          </div>
          <div class="col-sm-6 text-right">
            <h5 class="mb-3">Invoice Info:</h5>
            <div>Invoice No: <strong>{{ invoice.po_number }}</strong></div>
            <div>Date: {{ invoice.purchase_date }}</div>
          </div>
        </div>

        <div class="table-responsive-sm">
          <table class="table table-striped table-bordered">
            <thead>
              <tr>
                <th class="center">#</th>
                <th>Material Name</th>
                <th>Batch No</th>
                <th class="right">Unit Price</th>
                <th class="center">Qty</th>
                <th class="right">Total</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in invoice.items" :key="item.id">
                <td class="center">{{ index + 1 }}</td>
                <td class="left">{{ item.raw_material ? item.raw_material.name : 'N/A' }}</td>
                <td class="left">{{ item.batch_no || '-' }}</td>
                <td class="right">{{ item.unit_price }}</td>
                <td class="center">{{ item.quantity }}</td>
                <td class="right">{{ item.sub_total }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="row">
          <div class="col-lg-4 col-sm-5">
            <strong>Note:</strong> {{ invoice.note || 'No notes added.' }}
          </div>
          <div class="col-lg-4 col-sm-5 ml-auto">
            <table class="table table-clear">
              <tbody>
                <tr>
                  <td class="left"><strong>Subtotal</strong></td>
                  <td class="right">{{ invoice.total_amount }}</td>
                </tr>
                <tr>
                  <td class="left"><strong>Discount</strong></td>
                  <td class="right">{{ invoice.discount }}</td>
                </tr>
                <tr>
                  <td class="left"><strong>Grand Total</strong></td>
                  <td class="right"><strong>{{ invoice.total_amount - invoice.discount }}</strong></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return { invoice: {} };
  },
  mounted() {
    this.fetchInvoiceDetails();
  },
  methods: {
    async fetchInvoiceDetails() {
      const id = this.$route.params.id;
      try {
        // URL থেকে /api ফেলে দেওয়া হয়েছে
        const res = await axios.get(`/admin/purchases/${id}`);
        this.invoice = res.data;
      } catch (err) {
        console.error("View error:", err);
      }
    },
    printInvoice() { window.print(); }
  }
};
</script>

<style scoped>
@media print {
  .no-print {
    display: none !important;
  }
  .card {
    border: none !important;
  }
  .container-fluid {
    padding: 0 !important;
  }
}
.invoice-box {
  padding: 31px;
  border: 1px solid #eee;
  background: #fff;
}
</style>