<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm">
      <div class="card-header bg-lavender text-indigo d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Product Sale / Transfer List</h5>
        <router-link :to="{ name: 'product-sale-create' }" class="btn btn-sm btn-indigo">
          <i class="fas fa-plus mr-1"></i> New Sale
        </router-link>
      </div>

      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-hover table-bordered">
            <thead class="bg-light">
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
              <tr v-for="sale in sales" :key="sale.id">
                <td>{{ sale.sale_date }}</td>
                <td><strong>{{ sale.invoice_no }}</strong></td>
                <td>{{ sale.depo ? sale.depo.name : 'N/A' }}</td>
                <td>{{ sale.total_amount }}</td>
                <td>
                  <span :class="statusBadge(sale.status)">
                    {{ sale.status.toUpperCase() }}
                  </span>
                </td>
                <td class="text-center">
                  <button @click="viewInvoice(sale)" class="btn btn-sm btn-info">
                    <i class="fas fa-eye"></i> View
                  </button>
                </td>
              </tr>
              <tr v-if="sales.length === 0">
                <td colspan="6" class="text-center">No sales found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div v-if="showModal" class="modal-overlay">
      <div class="modal-content custom-modal">
        <div class="modal-header bg-indigo text-white">
          <h5 class="mb-0">Invoice Details - {{ selectedSale.invoice_no }}</h5>
          <button @click="showModal = false" class="close text-white">&times;</button>
        </div>
        <div class="modal-body p-4" id="printableInvoice">
          <div class="row mb-4">
            <div class="col-6">
              <h6><strong>From:</strong> Admin Warehouse</h6>
              <p>Date: {{ selectedSale.sale_date }}</p>
            </div>
            <div class="col-6 text-right">
              <h6><strong>To (Depo):</strong> {{ selectedSale.depo.name }}</h6>
              <p>Status: <strong>{{ selectedSale.status }}</strong></p>
            </div>
          </div>
          <table class="table table-sm table-bordered">
            <thead class="bg-light">
              <tr>
                <th>Product</th>
                <th class="text-center">Qty</th>
                <th class="text-right">Price</th>
                <th class="text-right">Subtotal</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in selectedSale.details" :key="item.id">
                <td>{{ item.product.product_name }}</td>
                <td class="text-center">{{ item.quantity }}</td>
                <td class="text-right">{{ item.unit_price }}</td>
                <td class="text-right">{{ item.subtotal }}</td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <th colspan="3" class="text-right">Grand Total:</th>
                <th class="text-right text-primary">{{ selectedSale.total_amount }}</th>
              </tr>
            </tfoot>
          </table>
          <p v-if="selectedSale.note" class="mt-3 small text-muted italic">Note: {{ selectedSale.note }}</p>
        </div>
        <div class="modal-footer">
          <button @click="showModal = false" class="btn btn-secondary">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

// ... (template and style remains same)

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
        // '/admin/' যোগ করা হয়েছে সঠিক রাউটিংয়ের জন্য
        const response = await axios.get('/api/admin/product-sales');
        // কন্ট্রোলার থেকে আসা 'data' অবজেক্টটি ধরা হচ্ছে
        this.sales = response.data.data; 
      } catch (error) {
        console.error("Error fetching sales:", error);
      }
    },
    viewInvoice(sale) {
      this.selectedSale = sale;
      this.showModal = true;
    },
    statusBadge(status) {
      if (status === 'pending') return 'badge badge-warning';
      if (status === 'accepted') return 'badge badge-success';
      return 'badge badge-danger';
    }
  }
};
</script>

<style scoped>
.bg-lavender { background-color: #f2efff; }
.text-indigo { color: #3f2b96; }
.bg-indigo { background-color: #3f2b96; }
.btn-indigo { background-color: #3f2b96; color: white; }

/* Modal Styles */
.modal-overlay {
  position: fixed; top: 0; left: 0; width: 100%; height: 100%;
  background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 9999;
}
.custom-modal {
  background: white; width: 80%; max-width: 700px; border-radius: 8px; overflow: hidden;
}
</style>