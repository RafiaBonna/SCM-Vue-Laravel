<template>
  <div class="container-fluid">

    <!-- Header (Same as Depo) -->
    <div class="content-header">
      <h1 class="m-0 text-info">Factory Return List</h1>
    </div>

    <section class="content">

      <!-- Action Button -->
      <div class="row mb-3">
        <div class="col-12">
          <button
            class="btn btn-info float-right"
            @click="showModal = true"
          >
            <i class="fas fa-undo"></i> New Return
          </button>
        </div>
      </div>

      <!-- Loading / Error -->
      <div v-if="loading" class="text-center text-primary">
        Loading Returns...
      </div>

      <div v-if="error" class="alert alert-danger">
        {{ error }}
      </div>

      <!-- Table Card -->
      <div class="card card-outline card-info">
        <div class="card-body p-0">
          <table class="table table-striped table-hover">
            <thead>
              <tr>
                <th style="width:10px">#</th>
                <th>Return No</th>
                <th>Date</th>
                <th>Product</th>
                <th class="text-center">Quantity</th>
                <th>Reason</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="(item, index) in returns" :key="item.id">
                <td>{{ index + 1 }}</td>
                <td><strong>{{ item.return_number }}</strong></td>
                <td>{{ item.return_date }}</td>
                <td>{{ item.product?.name || 'N/A' }}</td>
                <td class="text-center text-danger font-weight-bold">
                  {{ item.quantity }}
                </td>
                <td>{{ item.reason || 'N/A' }}</td>
              </tr>

              <tr v-if="!returns.length && !loading">
                <td colspan="6" class="text-center">
                  No Factory Returns found.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

    </section>

    <!-- Modal (Same page, like Depo Create button logic) -->
    <div v-if="showModal" class="modal fade show d-block" style="background:rgba(0,0,0,.5)">
      <div class="modal-dialog">
        <div class="modal-content">

          <div class="modal-header">
            <h5 class="modal-title">Add Factory Return</h5>
            <button type="button" class="close" @click="showModal = false">&times;</button>
          </div>

          <form @submit.prevent="saveReturn">
            <div class="modal-body">

              <div class="form-group">
                <label>Product</label>
                <select v-model="form.product_id" class="form-control" required>
                  <option value="">-- Select Product --</option>
                  <option
                    v-for="p in products"
                    :key="p.id"
                    :value="p.id"
                  >
                    {{ p.name }}
                  </option>
                </select>
              </div>

              <div class="form-group">
                <label>Quantity</label>
                <input
                  type="number"
                  class="form-control"
                  v-model="form.quantity"
                  min="1"
                  required
                >
              </div>

              <div class="form-group">
                <label>Return Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="form.return_date"
                  required
                >
              </div>

              <div class="form-group">
                <label>Reason</label>
                <textarea
                  class="form-control"
                  v-model="form.reason"
                ></textarea>
              </div>

            </div>

            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" @click="showModal = false">
                Cancel
              </button>
              <button type="submit" class="btn btn-info">
                Save Return
              </button>
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
  name: 'ProductReceiveReturnList',

  data() {
    return {
      returns: [],
      products: [],
      loading: false,
      error: null,
      showModal: false,
      form: {
        product_id: '',
        quantity: '',
        return_date: new Date().toISOString().slice(0, 10),
        reason: ''
      }
    }
  },

  mounted() {
    this.fetchReturns();
    this.fetchProducts();
  },

  methods: {
    async fetchReturns() {
      this.loading = true;
      this.error = null;
      try {
  const res = await axios.get('admin/product-returns');
        this.returns = res.data;
      } catch (err) {
        this.error = 'Failed to load Factory Returns';
      } finally {
        this.loading = false;
      }
    },

    async fetchProducts() {
      const res = await axios.get('admin/products');
      this.products = res.data.data || res.data;
    },

    async saveReturn() {
      try {
   const res = await axios.post('admin/product-returns', this.form);
        this.showModal = false;
        this.fetchReturns();
        alert('Factory Return saved successfully');
      } catch (err) {
        alert('Failed to save return');
      }
    }
  }
}
</script>
