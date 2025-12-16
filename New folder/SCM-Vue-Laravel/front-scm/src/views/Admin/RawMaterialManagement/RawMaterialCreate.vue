<template>
  <div class="container-fluid">
    <div class="content-header">
      <h1 class="m-0 text-info">Add Material to Master List</h1>
    </div>

    <section class="content">
      <div v-if="error" class="alert alert-danger">{{ error }}</div>
      
      <div class="card card-outline card-info">
        <div class="card-body">
          <form @submit.prevent="saveRawMaterial">
            <div class="row">
              <div class="col-md-6 form-group">
                <label>Material Name</label>
                <input type="text" v-model="form.name" class="form-control" placeholder="e.g. Sugar, Flour" required>
              </div>

              <div class="col-md-6 form-group">
                <label>Select Basic Unit</label>
                <select v-model="form.unit_id" class="form-control" required>
                  <option value="">-- Select Unit --</option>
                  <option v-for="unit in units" :key="unit.id" :value="unit.id">
                    {{ unit.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="row">
              <div class="col-md-6 form-group">
                <label>Alert Stock Level</label>
                <input type="number" step="0.01" v-model="form.alert_stock" class="form-control" placeholder="e.g. 10.00" required>
                <small class="text-muted">Minimum quantity to trigger low stock alert.</small>
              </div>
            </div>

            <div class="form-group">
              <label>Description (Optional)</label>
              <textarea v-model="form.description" class="form-control" rows="3"></textarea>
            </div>

            <button type="submit" class="btn btn-info" :disabled="loading">
              <i v-if="loading" class="fas fa-spinner fa-spin"></i>
              <i v-else class="fas fa-save"></i> Save to Master List
            </button>
            <router-link :to="{name: 'raw-material-list'}" class="btn btn-default ml-2">Cancel</router-link>
          </form>
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
      form: {
        name: '',
        unit_id: '',
        alert_stock: 0,
        description: ''
      },
      units: [],
      loading: false,
      error: null
    }
  },
  mounted() {
    this.fetchFormData();
  },
  methods: {
    async fetchFormData() {
      try {
        const response = await axios.get('admin/raw-materials/form-data');
        this.units = response.data.units;
      } catch (err) {
        this.error = "Failed to load units.";
      }
    },
    async saveRawMaterial() {
      this.loading = true;
      this.error = null;
      try {
        await axios.post('admin/raw-materials', this.form);
        alert("Material added to master list successfully!");
        this.$router.push({ name: 'raw-material-list' });
      } catch (err) {
        this.error = err.response?.data?.message || "Something went wrong!";
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>