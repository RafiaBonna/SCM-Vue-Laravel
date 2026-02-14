<template>
  <div class="container-fluid">
    <div class="content-header">
      <h1 class="m-0 text-info">Add New Product</h1>
    </div>

    <section class="content">
      <div class="card card-primary card-outline">
        <div class="card-header">
          <h3 class="card-title">Product Details</h3>
        </div>

        <form @submit.prevent="saveProduct">
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 form-group">
                <label>Product Name <span class="text-danger">*</span></label>
                <input v-model="form.name" type="text" class="form-control" placeholder="Ex: Wheat Flour 5kg" required>
              </div>

              <div class="col-md-6 form-group">
                <label>SKU / Product Code <span class="text-danger">*</span></label>
                <input v-model="form.sku" type="text" class="form-control" placeholder="Ex: WF-005" required>
              </div>

              <div class="col-md-4 form-group">
                <label>Unit <span class="text-danger">*</span></label>
                <select v-model="form.unit" class="form-control" required>
                  <option value="">Select Unit</option>
                  <option value="Pcs">Pcs</option>
                  <option value="Kg">Kg</option>
                  <option value="Litre">Litre</option>
                  <option value="Packet">Packet</option>
                </select>
              </div>

              <div class="col-md-4 form-group">
                <label>MRP (Retail Price) <span class="text-danger">*</span></label>
                <input v-model="form.mrp" type="number" step="0.01" class="form-control" placeholder="0.00" required>
              </div>

              <div class="col-md-4 form-group">
                <label>Distributor Rate <span class="text-danger">*</span></label>
                <input v-model="form.distributor_rate" type="number" step="0.01" class="form-control" placeholder="0.00" required>
              </div>

              <div class="col-md-12 form-group">
                <label>Status</label>
                <select v-model="form.status" class="form-control">
                  <option :value="1">Active</option>
                  <option :value="0">Inactive</option>
                </select>
              </div>
            </div>
          </div>

          <div class="card-footer text-right">
            <button type="button" class="btn btn-default mr-2" @click="$router.push({name: 'product-list'})">Cancel</button>
            <button type="submit" class="btn btn-primary" :disabled="loading">
              <span v-if="loading">Saving...</span>
              <span v-else>Save Product</span>
            </button>
          </div>
        </form>
      </div>
    </section>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      loading: false,
      form: {
        name: '',
        sku: '',
        unit: '',
        mrp: '',
        distributor_rate: '',
        status: 1
      }
    }
  },
  methods: {
    async saveProduct() {
      this.loading = true;
      try {
        await axios.post('admin/products', this.form);
        alert("Product created successfully!");
        this.$router.push({ name: 'product-list' });
      } catch (err) {
        if (err.response?.data?.errors) {
          alert("Error: " + Object.values(err.response.data.errors)[0][0]);
        } else {
          alert("Something went wrong!");
        }
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>
