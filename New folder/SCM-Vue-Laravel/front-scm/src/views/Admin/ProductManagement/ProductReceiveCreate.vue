<template>
  <div class="container-fluid">
    <div class="content-header">
      <h1 class="m-0 text-success">Receive Product from Factory</h1>
    </div>

    <section class="content">
      <div class="card card-success card-outline">
        <div class="card-header">
          <h3 class="card-title">Stock In Entry Form</h3>
        </div>

        <form @submit.prevent="saveReceive">
          <div class="card-body">
            <div class="row">
              <div class="col-md-4 form-group">
                <label>Receive Date <span class="text-danger">*</span></label>
                <input v-model="form.receive_date" type="date" class="form-control" required>
              </div>

              <div class="col-md-8 form-group">
                <label>Select Product <span class="text-danger">*</span></label>
                <select v-model="form.product_id" class="form-control" required>
                  <option value="">-- Choose Product --</option>
                  <option v-for="product in products" :key="product.id" :value="product.id">
                    {{ product.name }} (SKU: {{ product.sku }}) - Unit: {{ product.unit }}
                  </option>
                </select>
              </div>

              <div class="col-md-4 form-group">
                <label>Quantity <span class="text-danger">*</span></label>
                <input v-model="form.quantity" type="number" step="0.01" class="form-control" placeholder="0.00" required>
              </div>

              <div class="col-md-4 form-group">
                <label>Batch No (Optional)</label>
                <input v-model="form.batch_no" type="text" class="form-control" placeholder="Ex: BATCH-101">
              </div>

              <div class="col-md-4 form-group">
                <label>Note</label>
                <input v-model="form.note" type="text" class="form-control" placeholder="Any remarks">
              </div>
            </div>
          </div>

          <div class="card-footer text-right">
            <button type="button" class="btn btn-default mr-2" @click="$router.push({name: 'product-receive-list'})">Back to List</button>
            <button type="submit" class="btn btn-success" :disabled="submitting">
              <span v-if="submitting">Processing...</span>
              <span v-else><i class="fas fa-check"></i> Submit Stock In</span>
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
      submitting: false,
      products: [],
      form: {
        receive_date: new Date().toISOString().substr(0, 10),
        product_id: '',
        quantity: '',
        batch_no: '',
        note: ''
      }
    }
  },
  mounted() {
    this.loadFormData();
  },
  methods: {
    async loadFormData() {
      try {
        const res = await axios.get('admin/product-receives/get-form-data');
        this.products = res.data.products;
      } catch (err) {
        console.error("Failed to load products:", err);
      }
    },
    async saveReceive() {
      this.submitting = true;
      try {
        await axios.post('admin/product-receives', this.form);
        alert("Stock received successfully!");
        this.$router.push({ name: 'product-receive-list' });
      } catch (err) {
        if (err.response?.data?.errors) {
          alert("Error: " + Object.values(err.response.data.errors)[0][0]);
        } else {
          alert("Something went wrong during submission.");
        }
      } finally {
        this.submitting = false;
      }
    }
  }
}
</script>
