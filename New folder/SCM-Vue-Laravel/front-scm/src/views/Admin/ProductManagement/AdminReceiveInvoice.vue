<template>
  <div class="container-fluid mt-4">
    <div class="card" id="printableArea">
      <!-- Header Buttons -->
      <div class="card-header d-flex justify-content-between align-items-center no-print">
        <h3 class="card-title">Product Transfer Invoice</h3>
        <div>
          <button @click="printInvoice" class="btn btn-secondary mr-2">
            <i class="fas fa-print"></i> Print
          </button>
          <button @click="$router.back()" class="btn btn-primary">
            Back
          </button>
        </div>
      </div>

      <div class="card-body invoice-box" v-if="invoice">
        <!-- Company Header -->
        <div class="row mb-4">
          <div class="col-12 text-center border-bottom pb-3">
            <h2 class="font-weight-bold text-uppercase" style="color:#3f2b96;">
              <i class="fas fa-industry mr-2"></i> OPTICHAIN
            </h2>
            <p class="mb-0">Factory Supply Chain Management System</p>
            <h4 class="mt-2 font-weight-bold underline">
              ADMIN PRODUCT TRANSFER INVOICE
            </h4>
          </div>
        </div>

        <!-- Invoice Info -->
        <div class="row invoice-info mt-4">
          <div class="col-sm-6">
            <h5 class="text-muted border-bottom pb-1" style="width:fit-content;">
              Transfer Info
            </h5>
            <address>
              <strong>Transfer ID:</strong> #{{ invoice.id }}<br>
              <strong>Date:</strong> {{ invoice.sale_date }}<br>
              <strong>Status:</strong>
              <span class="badge badge-info">{{ invoice.status }}</span>
            </address>
          </div>

          <div class="col-sm-6 text-sm-right">
            <h5 class="text-muted border-bottom pb-1 ml-auto" style="width:fit-content;">
              Destination (Depo)
            </h5>
            <address>
              <strong>{{ invoice.depo ? invoice.depo.name : 'N/A' }}</strong><br>
              {{ invoice.depo ? invoice.depo.address : '' }}
            </address>
          </div>
        </div>

        <!-- Product Table -->
        <div class="row mt-4">
          <div class="col-12 table-responsive">
            <table class="table table-bordered custom-table">
              <thead class="bg-light">
                <tr>
                  <th style="width:5%">#</th>
                  <th>Product Name</th>
                  <th class="text-right">Quantity</th>
                  <th class="text-right">Unit Price</th>
                  <th class="text-right">Total</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item,index) in invoice.details" :key="item.id">
                  <td>{{ index + 1 }}</td>
                  <td>{{ item.product ? item.product.name : 'N/A' }}</td>
                  <td class="text-right">{{ item.quantity }}</td>
                  <td class="text-right">{{ item.unit_price }}</td>
                  <td class="text-right font-weight-bold">
                    {{ (item.quantity * item.unit_price).toFixed(2) }}
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Total -->
        <div class="row mt-4">
          <div class="col-12 text-right">
            <h4>
              Grand Total :
              <strong>{{ invoice.grand_total }} BDT</strong>
            </h4>
          </div>
        </div>

        <!-- Signature -->
        <div class="row mt-5">
          <div class="col-6"></div>
          <div class="col-6 text-right mt-5">
            <div class="d-inline-block text-center">
              <div style="border-top:2px solid #333;width:200px;padding-top:5px;">
                <strong>Authorized Admin Signature</strong>
              </div>
            </div>
          </div>
        </div>

        <!-- Print Footer -->
        <div class="row mt-5 pt-4 border-top d-none d-print-block">
          <div class="col-12 text-center text-muted">
            <small>
              This is a system generated invoice. Generated on:
              {{ new Date().toLocaleString() }}
            </small>
          </div>
        </div>
      </div>

      <div v-else class="text-center p-5">
        Loading Admin Invoice Data...
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      invoice: null
    };
  },
  mounted() {
    this.getAdminInvoice();
  },
  methods: {
    async getAdminInvoice() {
      const id = this.$route.params.id;
      const res = await axios.get(`/admin/product-sales/${id}`);
      this.invoice = res.data.data;
    },
    printInvoice() {
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

/* Print */
@media print {
  .no-print { display: none !important; }
  body { background: white; }
  .card { border: none !important; }
  .container-fluid { padding: 0 !important; }
}
</style>
