<template>
  <div class="container-fluid mt-4">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">New Raw Material Stock In</h3>
      </div>
      <div class="card-body">
        <form @submit.prevent="saveStockIn">
          <div class="row mb-4">
            <div class="col-md-3">
              <label>Invoice Number</label>
              <input v-model="form.invoice_number" type="text" class="form-control" required placeholder="PO-12345">
            </div>
            <div class="col-md-3">
              <label>Supplier</label>
              <select v-model="form.supplier_id" class="form-control" required>
                <option value="">Select Supplier</option>
                <option v-for="sup in suppliers" :key="sup.id" :value="sup.id">{{ sup.name }}</option>
              </select>
            </div>
            <div class="col-md-3">
              <label>Date</label>
              <input v-model="form.invoice_date" type="date" class="form-control" required>
            </div>
          </div>

          <table class="table table-bordered">
            <thead class="bg-light">
              <tr>
                <th width="30%">Material</th>
                <th>Batch No</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Sub Total</th>
                <th width="50px"></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in form.items" :key="index">
                <td>
                  <select v-model="item.raw_material_id" class="form-control" required>
                    <option value="">Select Material</option>
                    <option v-for="mat in materials" :key="mat.id" :value="mat.id">{{ mat.name }}</option>
                  </select>
                </td>
                <td><input v-model="item.batch_no" type="text" class="form-control" placeholder="Optional"></td>
                <td><input v-model.number="item.quantity" type="number" class="form-control" @input="calculateTotal" required></td>
                <td><input v-model.number="item.unit_price" type="number" step="0.01" class="form-control" @input="calculateTotal" required></td>
                <td><input :value="item.quantity * item.unit_price" type="number" class="form-control" readonly></td>
                <td>
                  <button type="button" @click="removeRow(index)" class="btn btn-danger btn-sm" :disabled="form.items.length === 1">
                    <i class="fas fa-trash"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>

          <button type="button" @click="addRow" class="btn btn-success btn-sm mb-4">
            <i class="fas fa-plus"></i> Add Row
          </button>

          <div class="row justify-content-end">
            <div class="col-md-4">
              <div class="form-group row">
                <label class="col-sm-6 text-right">Grand Total:</label>
                <div class="col-sm-6">
                  <input :value="form.grand_total" type="number" class="form-control" readonly>
                </div>
              </div>
              <div class="form-group row mt-2">
                <label class="col-sm-6 text-right font-weight-bold">Net Total:</label>
                <div class="col-sm-6">
                  <input :value="form.grand_total - form.discount" type="number" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-4 text-right">
            <button type="submit" class="btn btn-primary btn-lg" :disabled="loading">
              {{ loading ? 'Saving...' : 'Save Stock In' }}
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
  data() {
    return {
      loading: false,
      suppliers: [],
      materials: [],
      form: {
        invoice_number: '',
        supplier_id: '',
        invoice_date: new Date().toISOString().substr(0, 10),
        items: [{ raw_material_id: '', batch_no: '', quantity: 0, unit_price: 0, sub_total: 0 }],
        grand_total: 0,
        discount: 0,
        note: ''
      }
    };
  },
  mounted() {
    this.fetchFormData();
  },
  methods: {
    async fetchFormData() {
      try {
        // URL থেকে /api ফেলে দেওয়া হয়েছে
        const res = await axios.get('/admin/purchases/form-data');
        this.suppliers = res.data.suppliers;
        this.materials = res.data.materials;
      } catch (err) {
        console.error("Dropdown error:", err);
      }
    },
    addRow() {
      this.form.items.push({ raw_material_id: '', batch_no: '', quantity: 0, unit_price: 0, sub_total: 0 });
    },
    removeRow(index) {
      this.form.items.splice(index, 1);
      this.calculateTotal();
    },
    calculateTotal() {
      this.form.grand_total = this.form.items.reduce((acc, item) => acc + (item.quantity * item.unit_price), 0);
    },
    async saveStockIn() {
      this.loading = true;
      try {
        // URL থেকে /api ফেলে দেওয়া হয়েছে
        const res = await axios.post('/admin/purchases', this.form);
        alert("Saved successfully!");
        this.$router.push({ name: 'stock-in-list' });
      } catch (err) {
        alert(err.response?.data?.error || "Error saving data");
      } finally {
        this.loading = false;
      }
    }
  }
};
</script>