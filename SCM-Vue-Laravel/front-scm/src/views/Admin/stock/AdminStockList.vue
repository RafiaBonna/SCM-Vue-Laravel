<template>
  <div class="container-fluid">

    <!-- ===== Header ===== -->
    <div class="content-header">
      <h1 class="m-0 text-info">
        <i class="fas fa-boxes mr-2"></i> Master Stock Report
      </h1>
    </div>

    <!-- ===== Content ===== -->
    <section class="content">

      <div class="card card-outline card-info">
        <div class="card-header">
          <h3 class="card-title">Real-time Inventory Status</h3>
        </div>

        <div class="card-body p-0">
          <div class="table-responsive">

            <table class="table table-hover m-0">
              <thead>
                <tr>
                  <th class="px-4">Product</th>
                  <th class="text-center">Opening</th>
                  <th class="text-center">Received (+)</th>
                  <th class="text-center">Rec. Return (-)</th>
                  <th class="text-center">Sales (-)</th>
                  <th class="text-center">Sales Return (+)</th>
                  <th class="text-center">Wastage (-)</th>
                  <th class="text-center bg-info text-white">
                    Current Stock
                  </th>
                </tr>
              </thead>

              <tbody>
                <tr v-for="stock in stocks" :key="stock.id">
                  <td class="px-4">
                    <strong>{{ stock.product?.name }}</strong><br>
                    <small class="text-muted">
                      SKU: {{ stock.product?.sku }}
                    </small>
                  </td>

                  <td class="text-center">{{ stock.opening_stock }}</td>
                  <td class="text-center text-success font-weight-bold">
                    {{ stock.received_qty }}
                  </td>
                  <td class="text-center text-danger">
                    {{ stock.receive_return_qty }}
                  </td>
                  <td class="text-center text-danger font-weight-bold">
                    {{ stock.sales_qty }}
                  </td>
                  <td class="text-center text-info">
                    {{ stock.sales_return_qty }}
                  </td>
                  <td class="text-center text-warning font-weight-bold">
                    {{ stock.wastage_qty }}
                  </td>

                  <td class="text-center font-weight-bold text-info">
                    {{ stock.current_stock }}
                    {{ stock.product?.unit }}
                  </td>
                </tr>

                <tr v-if="stocks.length === 0">
                  <td colspan="8" class="text-center py-4 text-muted">
                    <i class="fas fa-box-open fa-2x d-block mb-2"></i>
                    No stock records found
                  </td>
                </tr>
              </tbody>
            </table>

          </div>
        </div>
      </div>

    </section>
  </div>
</template>


<script>
import axios from 'axios';
export default {
  data() {
    return { stocks: [] }
  },
  mounted() {
    this.fetchStocks();
  },
  methods: {
    async fetchStocks() {
      try {
        // এখানে আপনার প্রজেক্টের সঠিক API পাথ দিন। 
        // সাধারণত এটি /api/admin/admin-stocks হয়
       const res = await axios.get('admin/admin-stocks');
        this.stocks = res.data;
      } catch (err) {
        console.error("Error fetching stocks:", err);
      }
    }
  }
}
</script>