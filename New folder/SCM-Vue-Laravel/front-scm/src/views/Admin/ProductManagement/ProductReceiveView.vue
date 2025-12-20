<template>
  <div class="container-fluid mt-4">
    <div class="card" id="printableArea">
      <div class="card-header d-flex justify-content-between align-items-center no-print">
        <h3 class="card-title">Stock In Voucher</h3>
        <div>
          <button @click="printVoucher" class="btn btn-secondary mr-2">
            <i class="fas fa-print"></i> Print
          </button>
          <router-link :to="{ name: 'product-receive-list' }" class="btn btn-primary">
            Back to List
          </router-link>
        </div>
      </div>

      <div class="card-body invoice-box">
        <!-- Header -->
        <div class="row mb-4">
          <div class="col-12 text-center border-bottom pb-3">
            <h2 class="font-weight-bold text-uppercase" style="color: #3f2b96;">
              <i class="fas fa-industry mr-2"></i> OPTICHAIN
            </h2>
            <p class="mb-0">Factory Supply Chain Management System</p>
            <h4 class="mt-2 font-weight-bold underline">STOCK IN VOUCHER</h4>
          </div>
        </div>

        <!-- Transaction Info -->
        <div class="row invoice-info mt-4">
          <div class="col-sm-6 invoice-col">
            <h5 class="text-muted border-bottom pb-1" style="width: fit-content;">Transaction Info:</h5>
            <address>
              <strong>Voucher No:</strong> {{ receive?.receive_number }}<br>
              <strong>Batch No:</strong> {{ receive?.batch_no || 'N/A' }}<br>
              <strong>Receive Date:</strong> {{ receive?.receive_date }}<br>
              <strong>Status:</strong> <span class="badge badge-success">Verified Stock</span>
            </address>
          </div>

          <div class="col-sm-6 invoice-col text-sm-right">
            <h5 class="text-muted border-bottom pb-1 ml-auto" style="width: fit-content;">Reported To:</h5>
            <address>
              <strong>Main Warehouse</strong><br>
              Central Distribution Point<br>
              Factory Area, Dhaka
            </address>
          </div>
        </div>

        <!-- Items Table -->
        <div class="row mt-4">
          <div class="col-12 table-responsive">
            <table class="table table-bordered custom-table">
              <thead class="bg-light">
                <tr>
                  <th style="width: 10%">#</th>
                  <th>Raw Material Name</th>
                  <th>Batch No</th>
                  <th class="text-right">Quantity</th>
                </tr>
              </thead>
              <tbody v-if="receive">
                <tr>
                  <td>1</td>
                  <td>{{ receive.product ? receive.product.name : 'N/A' }}</td>
                  <td>{{ receive.batch_no || '-' }}</td>
                  <td class="text-right font-weight-bold">{{ receive.quantity }} {{ receive.product ? receive.product.unit : '' }}</td>
                </tr>
              </tbody>
              <tr v-else>
                <td colspan="4" class="text-center text-muted">No items found for this voucher.</td>
              </tr>
            </table>
          </div>
        </div>

        <!-- Notes & Signature -->
        <div class="row mt-5">
          <div class="col-6 mt-3">
            <p class="lead">Additional Notes:</p>
            <p class="text-muted well well-sm shadow-none p-2 border rounded bg-light" style="min-height: 60px;">
              {{ receive?.note || 'No additional remarks provided for this transaction.' }}
            </p>
          </div>

          <div class="col-6 mt-5 text-right">
            <div class="d-inline-block text-center mt-5">
              <div style="border-top: 2px solid #333; width: 200px; padding-top: 5px;">
                <strong>Store Officer Signature</strong>
              </div>
            </div>
          </div>
        </div>

        <!-- Print Footer -->
        <div class="row mt-5 pt-4 border-top d-none d-print-block">
          <div class="col-12 text-center text-muted">
            <small>This is a computer-generated voucher. Generated on: {{ new Date().toLocaleString() }}</small>
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
    return {
      receive: null
    };
  },
  mounted() {
    this.fetchReceiveDetails();
  },
  methods: {
    async fetchReceiveDetails() {
      const id = this.$route.params.id;
      try {
        const res = await axios.get(`admin/product-receives/${id}`);
        this.receive = res.data;
      } catch (err) {
        console.error("Error fetching voucher:", err);
      }
    },
    printVoucher() {
      window.print();
    }
  }
};
</script>

<style scoped>
.invoice-box {
  padding: 30px;
  border: 1px solid #eee;
  background: #fff;
}
.underline {
  text-decoration: underline;
  text-underline-offset: 5px;
}
.custom-table thead th {
  border-bottom: 2px solid #dee2e6;
  text-transform: uppercase;
  font-size: 14px;
}
.text-right { text-align: right; }
.text-center { text-align: center; }

/* Print styles */
@media print {
  .no-print { display: none !important; }
  body { background: white; }
  .card { border: none !important; }
  .container-fluid { padding: 0 !important; }
}
</style>
