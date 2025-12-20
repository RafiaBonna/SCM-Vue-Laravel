<template>
  <div class="container-fluid">
    <div class="content-header d-flex justify-content-between align-items-center mb-3">
      <h1 class="m-0 text-success">Product Receives (Stock In)</h1>
      <router-link :to="{ name: 'product-receive-create' }" class="btn btn-success">
        <i class="fas fa-download"></i> Receive From Factory
      </router-link>
    </div>

    <section class="content">
      <div class="card card-outline card-success">
        <div class="card-body p-0">
          <table class="table table-bordered table-striped mb-0">
            <thead class="thead-light">
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
                  <router-link 
                    :to="{ name: 'product-receive-view', params: { id: receive.id } }" 
                    class="btn btn-sm btn-info"
                  >
                    <i class="fas fa-eye"></i> View
                  </router-link>
                </td>
              </tr>
              <tr v-if="receives.length === 0">
                <td colspan="6" class="text-center text-muted">No receive records found.</td>
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
      receives: [],
      loading: false,
      error: null
    }
  },
  mounted() {
    this.fetchReceives();
  },
  methods: {
    async fetchReceives() {
      this.loading = true;
      this.error = null;
      try {
        const res = await axios.get('admin/product-receives');
        this.receives = res.data;
      } catch (err) {
        console.error("Error fetching receives:", err);
        this.error = "Failed to load receive records.";
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>
