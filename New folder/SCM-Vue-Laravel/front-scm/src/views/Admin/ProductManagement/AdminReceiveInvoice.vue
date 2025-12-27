<template>
  <div class="content-wrapper">
    <section class="content-header">
      <button @click="$router.back()" class="btn btn-secondary btn-sm mb-2">Back</button>
    </section>

    <section class="content">
      <div class="container-fluid">
        <div class="invoice p-3 mb-3" v-if="invoice">
          <div class="row">
            <div class="col-12 text-center border-bottom pb-2">
              <h3>ADMIN - PRODUCT TRANSFER INVOICE</h3>
              <p>Transfer ID: #{{ invoice.id }} | Date: {{ invoice.sale_date }}</p>
            </div>
          </div>

          <div class="row mt-4">
            <div class="col-sm-6">
              <strong>From:</strong><br>
              Main Warehouse (Admin)<br>
              Authorized Signature Required
            </div>
            <div class="col-sm-6 text-right">
              <strong>To (Depo):</strong><br>
              {{ invoice.depo ? invoice.depo.name : 'N/A' }}<br>
              {{ invoice.depo ? invoice.depo.address : '' }}
            </div>
          </div>

          <div class="row mt-4">
            <table class="table table-bordered table-striped">
              <thead class="bg-dark">
                <tr>
                  <th>Product Name</th>
                  <th>Quantity</th>
                  <th>Unit Price</th>
                  <th>Total</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="item in invoice.details" :key="item.id">
                  <td>{{ item.product ? item.product.name : 'N/A' }}</td>
                  <td>{{ item.quantity }}</td>
                  <td>{{ item.unit_price }}</td>
                  <td>{{ (item.quantity * item.unit_price).toFixed(2) }}</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="row">
            <div class="col-12 text-right">
              <h4>Grand Total: {{ invoice.grand_total }} BDT</h4>
              <p><strong>Status:</strong> <span class="badge badge-info">{{ invoice.status }}</span></p>
            </div>
          </div>
        </div>
        <div v-else class="text-center">Loading Admin Invoice Data...</div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() { return { invoice: null }; },
  mounted() { this.getAdminInvoice(); },
  methods: {
    async getAdminInvoice() {
      const id = this.$route.params.id;
      // Admin-er jonno api route jodi alada hoy tobe seta kheyal rakhun
      const res = await axios.get(`/admin/product-sales/${id}`); 
      this.invoice = res.data.data;
    }
  }
};
</script>