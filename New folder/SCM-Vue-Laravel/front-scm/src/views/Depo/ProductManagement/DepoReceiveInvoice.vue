<template>
  <div class="content-wrapper">
    <section class="content-header">
      <button @click="$router.back()" class="btn btn-secondary btn-sm mb-2">Back</button>
    </section>

    <section class="content">
      <div class="container-fluid">
        <div class="invoice p-3 mb-3" v-if="invoice">
          <div class="row">
            <div class="col-12 text-center">
              <h3>PRODUCT RECEIVE INVOICE</h3>
              <p>Transfer ID: #{{ invoice.id }} | Date: {{ invoice.sale_date }}</p>
            </div>
          </div>

          <div class="row mt-4 border-top pt-3">
            <div class="col-sm-6">
              <strong>From (Admin):</strong><br>
              Main Warehouse<br>
              Authorized Office
            </div>
            <div class="col-sm-6 text-right">
              <strong>To (Depo):</strong><br>
              {{ invoice.depo ? invoice.depo.name : 'N/A' }}<br>
              {{ invoice.depo ? invoice.depo.address : '' }}
            </div>
          </div>

          <div class="row mt-4">
            <table class="table table-bordered">
              <thead class="bg-light">
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
                  <td>{{ item.quantity * item.unit_price }}</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="row">
            <div class="col-12 text-right">
              <h4>Grand Total: {{ invoice.grand_total }} BDT</h4>
            </div>
          </div>
        </div>
        <div v-else class="text-center">Loading Invoice Data...</div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() { return { invoice: null }; },
  mounted() { this.getInvoice(); },
  methods: {
    async getInvoice() {
      const id = this.$route.params.id;
      // Axios call korar somoy /api/ api double jeno na hoy seta kheyal rakhben
      const res = await axios.get(`/depo/invoice/${id}`); 
      this.invoice = res.data.data;
    }
  }
};
</script>