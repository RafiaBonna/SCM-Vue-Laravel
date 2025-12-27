<template>
  <div class="content-wrapper">
    <section class="content-header">
      <div class="container-fluid">
        <h1>Depo Inventory Stock</h1>
      </div>
    </section>

    <section class="content">
      <div class="card">
        <div class="card-body p-0">
          <table class="table table-bordered table-striped m-0">
            <thead class="bg-navy">
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
                <td class="text-success">{{ stock.received_qty }}</td>
                <td class="text-danger">{{ stock.receive_return_qty }}</td>
                <td>{{ stock.sales_qty }}</td>
                <td>{{ stock.sales_return_qty }}</td>
                <td>{{ stock.wastage_qty }}</td>
                <td>
                  <span class="badge badge-primary" style="font-size: 1.1rem;">
                    {{ stock.current_stock }}
                  </span>
                </td>
              </tr>
              <tr v-if="stocks.length === 0">
                <td colspan="8" class="text-center">No stock records found in database.</td>
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
        const res = await axios.get("/api/depo/current-stock");
        this.stocks = res.data.data;
      } catch (err) {
        console.error("Stock fetch error:", err);
      }
    }
  }
};
</script>