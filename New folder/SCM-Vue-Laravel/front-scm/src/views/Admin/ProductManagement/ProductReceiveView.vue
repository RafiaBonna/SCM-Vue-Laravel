<template>
  <div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Receive Details</h1>
          </div>
          <div class="col-sm-6 text-right">
            <button @click="$router.push({ name: 'product-receive-list' })" class="btn btn-secondary">
              <i class="fas fa-arrow-left"></i> Back to List
            </button>
            <button @click="printReceipt" class="btn btn-primary ml-2">
              <i class="fas fa-print"></i> Print
            </button>
          </div>
        </div>
      </div>
    </section>

    <section class="content" v-if="receive">
      <div class="invoice p-3 mb-3">
        <div class="row">
          <div class="col-12">
            <h4>
              <i class="fas fa-globe"></i> SCM PANEL
              <small class="float-right">Date: {{ receive.receive_date }}</small>
            </h4>
          </div>
        </div>
        
        <hr>

        <div class="row invoice-info">
          <div class="col-sm-6 invoice-col">
            <b>Receive Number:</b> {{ receive.receive_number }}<br>
            <b>Batch No:</b> {{ receive.batch_no || 'N/A' }}<br>
            <b>Status:</b> <span class="badge badge-success">Stock In Done</span>
          </div>
          <div class="col-sm-6 invoice-col">
            <b>Product Name:</b> {{ receive.product ? receive.product.name : 'N/A' }}<br>
            <b>SKU:</b> {{ receive.product ? receive.product.sku : 'N/A' }}<br>
            <b>Quantity:</b> {{ receive.quantity }} {{ receive.product ? receive.product.unit : '' }}
          </div>
        </div>
        <br>

        <div class="row">
          <div class="col-12">
            <p class="lead">Note:</p>
            <p class="text-muted well well-sm shadow-none" style="margin-top: 10px;">
              {{ receive.note || 'No additional notes provided.' }}
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      receive: null
    }
  },
  mounted() {
    this.fetchReceiveDetails();
  },
  methods: {
    async fetchReceiveDetails() {
      try {
        const id = this.$route.params.id;
        const res = await axios.get(`/api/admin/product-receives/${id}`);
        this.receive = res.data;
      } catch (err) {
        console.error("Error fetching details:", err);
        alert("Could not load details.");
      }
    },
    printReceipt() {
      window.print();
    }
  }
}
</script>

<style scoped>
@media print {
  .btn, .content-header {
    display: none !important;
  }
  .content-wrapper {
    margin: 0 !important;
    padding: 0 !important;
  }
}
</style>