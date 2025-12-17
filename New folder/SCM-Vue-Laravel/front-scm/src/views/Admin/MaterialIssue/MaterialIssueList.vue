<template>
  <div class="container-fluid mt-4">
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h3 class="card-title">Material Issue History (Stock Out)</h3>
        <router-link :to="{ name: 'material-issue-create' }" class="btn btn-primary">
          <i class="fas fa-plus"></i> Issue New Material
        </router-link>
      </div>
      <div class="card-body">
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>Date</th>
              <th>Issue No</th>
              <th>Note</th>
              <th class="text-center">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="issue in issues" :key="issue.id">
              <td>{{ issue.issue_date }}</td>
              <td><strong>{{ issue.issue_number }}</strong></td>
              <td>{{ issue.note || 'No notes' }}</td>
              <td class="text-center">
                <button @click="viewInvoice(issue.id)" class="btn btn-info btn-sm">
                  <i class="fas fa-eye"></i> View Slip
                </button>
              </td>
            </tr>
            <tr v-if="issues.length === 0">
              <td colspan="4" class="text-center">No issue records found.</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'MaterialIssueList',
  data() {
    return {
      issues: []
    };
  },
  mounted() {
    this.fetchIssues();
  },
  methods: {
    async fetchIssues() {
      try {
        const response = await axios.get('admin/material-issues');
        this.issues = response.data;
      } catch (error) {
        console.error("Error fetching issues:", error);
      }
    },
    viewInvoice(id) {
      // আমরা পরে একটি View পেজ বানাবো, আপাতত এই রাউটে পাঠাচ্ছি
      this.$router.push({ name: 'material-issue-view', params: { id: id } });
    }
  }
};
</script>