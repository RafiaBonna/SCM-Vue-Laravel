<template>
  <div class="container-fluid">

    <!-- Header -->
    <div class="content-header mb-3">
      <div class="row">
        <div class="col-sm-6">
          <h1 class="m-0 text-primary">
            <i class="fas fa-trash-alt mr-2"></i> Product Wastage
          </h1>
        </div>
        <div class="col-sm-6 text-right">
          <button class="btn btn-primary" @click="showModal = true">
            <i class="fas fa-plus mr-1"></i> Record Wastage
          </button>
        </div>
      </div>
    </div>

    <!-- Table Card -->
    <section class="content">
      <div class="card card-outline card-primary shadow-sm">
        <div class="card-body p-0">
          <table class="table table-hover table-striped m-0">
            <thead class="thead-light">
              <tr>
                <th>#</th>
                <th>Wastage ID</th>
                <th>Date</th>
                <th>Product</th>
                <th class="text-center">Quantity</th>
                <th>Remarks</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in wastages" :key="item.id">
                <td>{{ index + 1 }}</td>
                <td><strong>{{ item.wastage_number }}</strong></td>
                <td>{{ item.date }}</td>
                <td>{{ item.product?.name || 'N/A' }}</td>
                <td class="text-center text-warning font-weight-bold">{{ item.quantity }}</td>
                <td>{{ item.remarks || 'N/A' }}</td>
              </tr>
              <tr v-if="!wastages.length">
                <td colspan="6" class="text-center text-muted py-4">No wastage records found.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>

    <!-- Modal -->
    <div v-if="showModal" class="modal fade show d-block" style="background: rgba(0,0,0,0.5);">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title">Record New Wastage</h5>
            <button type="button" class="close" @click="showModal = false">&times;</button>
          </div>
          <form @submit.prevent="saveWastage">
            <div class="modal-body">
              <div class="form-group">
                <label>Product</label>
                <select v-model="form.product_id" class="form-control" required>
                  <option value="" disabled>-- Select Product --</option>
                  <option v-for="p in products" :key="p.id" :value="p.id">{{ p.name }}</option>
                </select>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" v-model="form.quantity" class="form-control" min="1" required>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label>Date</label>
                    <input type="date" v-model="form.date" class="form-control" required>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label>Remarks</label>
                <textarea v-model="form.remarks" class="form-control" rows="2" placeholder="Reason (optional)"></textarea>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" @click="showModal = false">Cancel</button>
              <button type="submit" class="btn btn-primary">Save Wastage</button>
            </div>
          </form>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'ProductWastage',
  data() {
    return {
      wastages: [],
      products: [],
      showModal: false,
      form: {
        product_id: '',
        quantity: '',
        date: new Date().toISOString().slice(0, 10),
        remarks: ''
      }
    }
  },
  mounted() {
    this.fetchWastages();
    this.fetchProducts();
  },
  methods: {
    async fetchWastages() {
      try {
        const res = await axios.get('admin/product-wastages');
        this.wastages = res.data;
      } catch (err) {
        console.error('Failed to fetch wastages', err);
      }
    },
    async fetchProducts() {
      try {
        const res = await axios.get('admin/products');
        this.products = res.data.data || res.data;
      } catch (err) {
        console.error('Failed to fetch products', err);
      }
    },
    async saveWastage() {
      try {
        await axios.post('admin/product-wastages', this.form);
        this.showModal = false;
        this.fetchWastages();
        this.form = { product_id: '', quantity: '', date: new Date().toISOString().slice(0, 10), remarks: '' };
        alert('Wastage recorded successfully!');
      } catch (err) {
        alert('Error: Please check stock or input.');
      }
    }
  }
}
</script>

<style scoped>
.table-hover tbody tr:hover {
  background-color: #f2efff;
}

.modal-header.bg-primary {
  background-color: #6a5acd !important;
}

.modal-footer .btn-primary {
  background-color: #6a5acd !important;
  border-radius: 8px;
}

.card {
  border-radius: 12px;
}
</style>
