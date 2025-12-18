<template>
  <div class="content-wrapper">
    <section class="content-header">
      
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Product List (Finished Goods)</h1>
          </div>
          <div class="col-sm-6 text-right">
            <router-link :to="{ name: 'product-create' }" class="btn btn-primary">
              <i class="fas fa-plus"></i> Add New Product
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <section class="content">
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">All Products</h3>
        </div>
        <div class="card-body p-0">
          <table class="table table-striped table-hover">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>SKU/Code</th>
                <th>Unit</th>
                <th>MRP</th>
                <th>Distributor Rate</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="product in products" :key="product.id">
                <td>{{ product.id }}</td>
                <td>{{ product.name }}</td>
                <td><span class="badge badge-info">{{ product.sku }}</span></td>
                <td>{{ product.unit }}</td>
                <td>{{ product.mrp }} TK</td>
                <td>{{ product.distributor_rate }} TK</td>
                <td>
                  <span v-if="product.status" class="badge badge-success">Active</span>
                  <span v-else class="badge badge-danger">Inactive</span>
                </td>
              </tr>
              <tr v-if="products.length === 0 && !loading">
                <td colspan="7" class="text-center">No products found. Please add one.</td>
              </tr>
              <tr v-if="loading">
                <td colspan="7" class="text-center">Loading...</td>
              </tr>
            </tbody>
          </table>
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
      products: [],
      loading: false
    }
  },
  mounted() {
    this.fetchProducts();
  },
  methods: {
    // ... (অন্যান্য কোড ঠিক থাকবে, শুধু fetchProducts মেথডটি দেখুন)
    async fetchProducts() {
      this.loading = true;
      try {
        // সঠিক পাথ: 'admin/products' (আগে ছিল '/api/admin/products')
        const res = await axios.get('admin/products'); 
        this.products = res.data;
      } catch (err) {
        console.error("Error fetching products:", err);
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>