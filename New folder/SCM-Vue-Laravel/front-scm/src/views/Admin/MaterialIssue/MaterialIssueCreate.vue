<template>
  <div class="container-fluid mt-4">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Issue Raw Material to Factory (Stock Out)</h3>
      </div>
      <div class="card-body">
        <form @submit.prevent="saveMaterialIssue">
          <div class="row mb-4">
            <div class="col-md-4">
              <label>Issue Date</label>
              <input v-model="form.issue_date" type="date" class="form-control" required>
            </div>
            <div class="col-md-8">
              <label>Note / Purpose</label>
              <input v-model="form.note" type="text" class="form-control" placeholder="e.g. For Production Batch #101">
            </div>
          </div>

          <table class="table table-bordered">
            <thead class="bg-dark text-white">
              <tr>
                <th width="40%">Material Name</th>
                <th>Batch No (Optional)</th>
                <th width="20%">Quantity to Issue</th>
                <th width="50px"></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in form.items" :key="index">
                <td>
                  <select v-model="item.raw_material_id" class="form-control" required>
                    <option value="">-- Select Material --</option>
                    <option v-for="mat in materials" :key="mat.id" :value="mat.id">
                      {{ mat.name }}
                    </option>
                  </select>
                </td>
                <td>
                  <input v-model="item.batch_no" type="text" class="form-control" placeholder="Batch No">
                </td>
                <td>
                  <input v-model="item.quantity" type="number" step="0.01" class="form-control" required min="0.01">
                </td>
                <td>
                  <button v-if="form.items.length > 1" @click="removeRow(index)" type="button" class="btn btn-danger btn-sm">
                    <i class="fas fa-trash"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>

          <button @click="addRow" type="button" class="btn btn-success btn-sm mb-3">
            <i class="fas fa-plus"></i> Add Item
          </button>

          <div class="text-right">
            <router-link :to="{ name: 'material-issue-list' }" class="btn btn-secondary mr-2">Cancel</router-link>
            <button type="submit" class="btn btn-primary" :disabled="loading">
              {{ loading ? 'Processing...' : 'Save Issue Record' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'MaterialIssueCreate',
  data() {
    return {
      loading: false,
      materials: [],
      form: {
        issue_date: new Date().toISOString().substr(0, 10),
        note: '',
        items: [
          { raw_material_id: '', batch_no: '', quantity: 1 }
        ]
      }
    };
  },
  mounted() {
    this.fetchMaterials();
  },
  methods: {
    // ১. ড্রপডাউনের জন্য মেটেরিয়াল লিস্ট নিয়ে আসা
    async fetchMaterials() {
      try {
        // সঠিক এন্ডপয়েন্ট: admin/material-issues/form-data
        const res = await axios.get('admin/material-issues/form-data');
        this.materials = res.data.materials;
      } catch (err) {
        console.error("Error fetching materials:", err);
      }
    },
    addRow() {
      this.form.items.push({ raw_material_id: '', batch_no: '', quantity: 1 });
    },
    removeRow(index) {
      this.form.items.splice(index, 1);
    },
    // ২. ডাটা সেভ করা
    async saveMaterialIssue() {
      if (!confirm("Are you sure you want to issue these materials? This will reduce your stock.")) return;
      
      this.loading = true;
      try {
        const res = await axios.post('admin/material-issues', this.form);
        alert(res.data.message || "Material issued successfully!");
        this.$router.push({ name: 'material-issue-list' });
      } catch (err) {
        console.error("Save Error:", err.response);
        alert(err.response?.data?.error || "Something went wrong! Please check console.");
      } finally {
        this.loading = false;
      }
    }
  }
};
</script>