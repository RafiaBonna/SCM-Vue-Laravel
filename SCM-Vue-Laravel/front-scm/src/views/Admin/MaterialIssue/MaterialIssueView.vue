<template>
  <div class="container-fluid mt-4">
    <div class="card" id="printableArea">
      <div class="card-header d-flex justify-content-between align-items-center no-print">
        <h3 class="card-title">Material Issue Slip (Stock Out)</h3>
        <div>
          <button @click="printSlip" class="btn btn-secondary mr-2">
            <i class="fas fa-print"></i> Print Slip
          </button>
          <router-link :to="{ name: 'material-issue-list' }" class="btn btn-primary">
            Back to List
          </router-link>
        </div>
      </div>
      
      <div class="card-body invoice-box">
        <div class="row mb-4">
          <div class="col-sm-6">
            <h5 class="mb-3">From: Central Warehouse</h5>
            <div><strong>Main Stock Store</strong></div>
            <div>To: Factory Production Floor</div>
          </div>
          <div class="col-sm-6 text-right">
            <h5 class="mb-3">Issue Details:</h5>
            <div>Issue No: <strong>{{ issue.issue_number }}</strong></div>
            <div>Date: {{ issue.issue_date }}</div>
          </div>
        </div>

        <div class="table-responsive-sm">
          <table class="table table-striped table-bordered">
            <thead>
              <tr>
                <th class="center">#</th>
                <th>Material Name</th>
                <th>Batch No</th>
                <th class="center">Issued Qty</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in issue.items" :key="item.id">
                <td class="center">{{ index + 1 }}</td>
                <td class="left">{{ item.raw_material ? item.raw_material.name : 'N/A' }}</td>
                <td class="left">{{ item.batch_no || '-' }}</td>
                <td class="center">{{ item.quantity }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="row mt-4">
          <div class="col-12">
            <strong>Note:</strong> {{ issue.note || 'No additional notes.' }}
          </div>
        </div>

        <div class="row mt-5 pt-5">
            <div class="col-4 text-center">___________________<br>Store Keeper</div>
            <div class="col-4 text-center">___________________<br>Receiver</div>
            <div class="col-4 text-center">___________________<br>Authorized</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return { issue: {} };
  },
  mounted() {
    this.fetchIssueDetails();
  },
  methods: {
    async fetchIssueDetails() {
      const id = this.$route.params.id;
      try {
        const res = await axios.get(`admin/material-issues/${id}`);
        this.issue = res.data;
      } catch (err) {
        alert("Could not load issue details.");
      }
    },
    printSlip() {
      window.print();
    }
  }
};
</script>

<style scoped>
@media print {
  .no-print { display: none !important; }
  .card { border: none !important; }
}
.invoice-box { padding: 30px; border: 1px solid #eee; background: #fff; }
</style>