<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm">
      <div class="card-header bg-lavender text-indigo d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Create Product Sale (Transfer to Depo)</h5>
        <router-link :to="{ name: 'product-sale-list' }" class="btn btn-sm btn-outline-indigo">
          <i class="fas fa-list mr-1"></i> Back to List
        </router-link>
      </div>

      <div class="card-body">
        <form @submit.prevent="submitSale">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Select Depo <span class="text-danger">*</span></label>
              <select v-model="form.depo_id" class="form-control" required>
                <option value="">-- Choose Depo --</option>
                <option v-for="depo in depos" :key="depo.id" :value="depo.id">
                  {{ depo.name }}
                </option>
              </select>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Sale Date <span class="text-danger">*</span></label>
              <input type="date" v-model="form.sale_date" class="form-control" required />
            </div>
          </div>

          <div class="table-responsive mt-4">
            <table class="table table-bordered">
              <thead class="bg-light">
                <tr>
                  <th style="width: 40%">Product</th>
                  <th>Quantity</th>
                  <th>Unit Price</th>
                  <th>Subtotal</th>
                  <th style="width: 50px"></th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, index) in form.items" :key="index">
                  <td>
                    <select v-model="item.product_id" class="form-control" required>
                      <option value="">-- Select Product --</option>
                      <option v-for="prod in products" :key="prod.id" :value="prod.id">
                        {{ prod.name }}
                      </option>
                    </select>
                  </td>
                  <td>
                    <input type="number" v-model.number="item.quantity" class="form-control" min="1" required />
                  </td>
                  <td>
                    <input type="number" v-model.number="item.unit_price" class="form-control" min="0" required />
                  </td>
                  <td class="align-middle text-right">
                    {{ (item.quantity * item.unit_price).toFixed(2) }}
                  </td>
                  <td>
                    <button type="button" @click="removeItem(index)" class="btn btn-sm btn-danger" :disabled="form.items.length === 1">
                      <i class="fas fa-trash"></i>
                    </button>
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="3" class="text-right font-weight-bold">Grand Total:</td>
                  <td class="text-right font-weight-bold text-primary">{{ calculateTotal }}</td>
                  <td></td>
                </tr>
              </tfoot>
            </table>
          </div>

          <button type="button" @click="addRow" class="btn btn-sm btn-success mt-2">
            <i class="fas fa-plus mr-1"></i> Add Product
          </button>

          <div class="mt-4">
            <label class="form-label">Note (Optional)</label>
            <textarea v-model="form.note" class="form-control" rows="2"></textarea>
          </div>

          <div class="text-right mt-4">
            <button type="submit" class="btn btn-indigo px-5" :disabled="loading">
              <span v-if="loading">Processing...</span>
              <span v-else>Send to Depo</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

// ... (template remains same)

<script>
import axios from 'axios';

export default {
  data() {
    return {
      depos: [],
      products: [],
      loading: false,
      form: {
        depo_id: '',
        sale_date: new Date().toISOString().substr(0, 10),
        items: [{ product_id: '', quantity: 1, unit_price: 0 }],
        total_amount: 0,
        note: ''
      }
    };
  },
  computed: {
    calculateTotal() {
      const total = this.form.items.reduce((sum, item) => sum + (item.quantity * item.unit_price), 0);
      this.form.total_amount = total;
      return total.toFixed(2);
    }
  },
  mounted() {
    this.fetchInitialData();
  },
  methods: {
    async fetchInitialData() {
      try {
        // রুট প্রিফিক্স 'admin' অনুযায়ী ইউআরএল আপডেট
        const [depoRes, prodRes] = await Promise.all([
          axios.get('/admin/depos'),
          axios.get('/admin/products')
        ]);
        this.depos = depoRes.data;
        this.products = prodRes.data;
      } catch (error) {
        console.error("Error fetching initial data:", error);
      }
    },
    addRow() {
      this.form.items.push({ product_id: '', quantity: 1, unit_price: 0 });
    },
    removeItem(index) {
      this.form.items.splice(index, 1);
    },
    async submitSale() {
      this.loading = true;
      try {
        // সঠিক এপিআই পাথ ব্যবহার
        await axios.post('/admin/product-sales', this.form);
        alert('Product transferred to Depo successfully!');
        this.$router.push({ name: 'product-sale-list' });
      } catch (error) {
        alert('Failed to save. Check all fields.');
      } finally {
        this.loading = false;
      }
    }
  }
};
</script>
<style scoped>
.bg-lavender { background-color: #f2efff; }
.text-indigo { color: #3f2b96; }
.btn-indigo { background-color: #3f2b96; color: white; }
.btn-outline-indigo { border-color: #3f2b96; color: #3f2b96; }
</style>