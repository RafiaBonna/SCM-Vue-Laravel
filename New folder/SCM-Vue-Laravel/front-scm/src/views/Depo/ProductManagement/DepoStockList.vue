<template>
  <div class="container-fluid">
    <!-- Header -->
    <div class="content-header d-flex justify-content-between align-items-center mb-3">
      <h1 class="m-0 text-primary">
        <i class="fas fa-warehouse mr-2"></i> Depo Inventory Stock
      </h1>
    </div>

    <!-- Content -->
    <section class="content">
      <div class="card card-outline card-primary">
        <div class="card-body p-0">
          <table class="table table-bordered table-striped mb-0">
            <thead class="thead-light">
              <tr>
                <th>Product Name</th>
                <th>Opening</th>
                <th>Received</th>
                <th>Rec. Return</th>
                <th>Sales</th>
                <th>Sales Return</th>
                <th>Wastage</th>
                <th>Current Stock</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="stock in stocks" :key="stock.id">
                <td><b>{{ stock.product ? stock.product.name : 'N/A' }}</b></td>
                <td>{{ stock.opening_stock }}</td>
                <td class="text-success font-weight-bold">
                  {{ stock.received_qty }}
                </td>
                <td class="text-danger font-weight-bold">
                  {{ stock.receive_return_qty }}
                </td>
                <td>{{ stock.sales_qty }}</td>
                <td>{{ stock.sales_return_qty }}</td>
                <td class="text-warning font-weight-bold">
                  {{ stock.wastage_qty }}
                </td>
                <td>
                  <span class="badge badge-primary px-3 py-2" style="font-size: 1rem;">
                    {{ stock.current_stock }}
                  </span>
                </td>
              </tr>

              <tr v-if="stocks.length === 0">
                <td colspan="8" class="text-center text-muted py-3">
                  No stock records found in database.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      stocks: [],
    };
  },
  mounted() {
    this.getStocks();
  },
  methods: {
    async getStocks() {
      try {
        const res = await axios.get("/depo/current-stock");
        this.stocks = res.data.data;
      } catch (err) {
        console.error("Stock fetch error:", err);
      }
    }
  }
};
</script>
