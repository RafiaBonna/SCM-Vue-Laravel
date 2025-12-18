<template>
  <div class="content-wrapper">
    <section class="content-header d-print-none">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Stock In Voucher</h1>
          </div>
          <div class="col-sm-6 text-right">
            <button @click="$router.push({ name: 'product-receive-list' })" class="btn btn-default">
              <i class="fas fa-arrow-left"></i> Back
            </button>
            <button @click="printReceipt" class="btn btn-primary ml-2">
              <i class="fas fa-print"></i> Print Voucher
            </button>
          </div>
        </div>
      </div>
    </section>

    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="invoice p-5 mb-3 rounded shadow-sm">
              <div class="row mb-4">
                <div class="col-12 text-center border-bottom pb-3">
                  <h2 class="font-weight-bold text-uppercase" style="color: #3f2b96;">
                    <i class="fas fa-industry mr-2"></i> OPTICHAIN
                  </h2>
                  <p class="mb-0">Factory Supply Chain Management System</p>
                  <h4 class="mt-2 font-weight-bold underline">STOCK IN VOUCHER</h4>
                </div>
              </div>

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
                    Factory Area, Dhaka<br>
                  </address>
                </div>
              </div>

              <div class="row mt-4">
                <div class="col-12 table-responsive">
                  <table class="table table-bordered custom-table">
                    <thead class="bg-light">
                      <tr>
                        <th style="width: 10%">#</th>
                        <th>Product Details</th>
                        <th class="text-center">SKU</th>
                        <th class="text-right">Received Quantity</th>
                      </tr>
                    </thead>
                    <tbody v-if="receive">
                      <tr>
                        <td>1</td>
                        <td>
                          <strong>{{ receive.product ? receive.product.name : 'N/A' }}</strong>
                        </td>
                        <td class="text-center">{{ receive.product ? receive.product.sku : 'N/A' }}</td>
                        <td class="text-right font-weight-bold">
                          {{ receive.quantity }} {{ receive.product ? receive.product.unit : '' }}
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

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
              
              <div class="row mt-5 pt-4 border-top d-none d-print-block">
                <div class="col-12 text-center text-muted">
                   <small>This is a computer-generated voucher. Generated on: {{ new Date().toLocaleString() }}</small>
                </div>
              </div>
            </div>
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
        // পাথ থেকে /api/ বাদ দেওয়া হয়েছে আপনার সিস্টেমের সাথে মিল রেখে
        const res = await axios.get(`admin/product-receives/${id}`);
        this.receive = res.data;
      } catch (err) {
        console.error("Error fetching details:", err);
      }
    },
    printReceipt() {
      window.print();
    }
  }
}
</script>

<style scoped>
.invoice {
  background: #fff;
  border: 1px solid #dee2e6;
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

/* প্রিন্ট সেটিং */
@media print {
  .content-wrapper {
    margin: 0 !important;
    padding: 0 !important;
  }
  .main-footer, .main-header, .main-sidebar, .d-print-none {
    display: none !important;
  }
  .invoice {
    border: none !important;
    padding: 0 !important;
    margin: 0 !important;
    box-shadow: none !important;
  }
  body {
    background: white;
  }
}
</style>