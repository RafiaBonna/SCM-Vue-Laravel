<template>
  <div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Product Receives (Stock In)</h1>
          </div>
          <div class="col-sm-6 text-right">
            <router-link :to="{ name: 'product-receive-create' }" class="btn btn-success">
              <i class="fas fa-download"></i> Receive From Factory
            </router-link>
          </div>
        </div>
      </div>
    </section>

    <section class="content">
      <div class="card">
        <div class="card-body p-0">
          <table class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>Date</th>
                <th>Receive No</th>
                <th>Product Name</th>
                <th>Batch No</th>
                <th>Quantity</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="receive in receives" :key="receive.id">
                <td>{{ receive.receive_date }}</td>
                <td><b>{{ receive.receive_number }}</b></td>
                <td>{{ receive.product ? receive.product.name : 'N/A' }}</td>
                <td>{{ receive.batch_no || 'N/A' }}</td>
                <td>{{ receive.quantity }} {{ receive.product ? receive.product.unit : '' }}</td>
                <td>
                  <router-link :to="{ name: 'product-receive-view', params: { id: receive.id } }" class="btn btn-sm btn-info">
                    <i class="fas fa-eye"></i> View
                  </router-link>
                </td>
              </tr>
              <tr v-if="receives.length === 0">
                <td colspan="6" class="text-center">No receive records found.</td>
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
      receives: []
    }
  },
  mounted() {
    this.fetchReceives();
  },
  methods: {
    async fetchReceives() {
      try {
        // API Route: /api/admin/product-receives
        const res = await axios.get('/api/admin/product-receives');
        this.receives = res.data;
      } catch (err) {
        console.error("Error:", err);
      }
    }
  }
}
</script>