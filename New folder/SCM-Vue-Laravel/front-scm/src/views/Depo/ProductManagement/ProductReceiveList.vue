<template>
  <div class="container-fluid py-4">
    <div class="card shadow-sm">
      <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Product Receive List (From Admin)</h5>
      </div>

      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-hover table-bordered">
            <thead class="bg-light">
              <tr>
                <th>Date</th>
                <th>Invoice No</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th class="text-center">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in receives" :key="item.id">
                <td>{{ item.sale_date }}</td>
                <td><strong>{{ item.invoice_no }}</strong></td>
                <td>{{ item.total_amount }}</td>
                <td>
                  <span :class="statusBadge(item.status)">
                    {{ item.status.toUpperCase() }}
                  </span>
                </td>
                <td class="text-center">
                  <router-link :to="{ name: 'depo-receive-invoice', params: { id: item.id } }" class="btn btn-sm btn-info mr-2">
                    <i class="fas fa-eye"></i> View Invoice
                  </router-link>

                  <template v-if="item.status === 'pending'">
                    <button @click="receiveProduct(item.id)" class="btn btn-sm btn-success mr-1">
                      <i class="fas fa-check-circle"></i> Receive
                    </button>
                    <button @click="openRejectModal(item.id)" class="btn btn-sm btn-danger">
                      <i class="fas fa-times-circle"></i> Reject
                    </button>
                  </template>
                  <span v-else class="badge badge-light border text-muted small ml-1">Processed</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div v-if="showRejectModal" class="modal d-block" style="background: rgba(0,0,0,0.5)">
      <div class="modal-dialog">
        <div class="modal-content shadow-lg">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title">Reject Products</h5>
            <button type="button" class="close text-white" @click="showRejectModal = false">&times;</button>
          </div>
          <div class="modal-body">
            <label>Reason for rejection (Note):</label>
            <textarea v-model="rejectNote" class="form-control" rows="3" placeholder="Explain why you are rejecting..."></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="showRejectModal = false">Cancel</button>
            <button type="button" class="btn btn-danger" @click="confirmReject" :disabled="!rejectNote">Confirm Reject</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      receives: [],
      loading: false,
      showRejectModal: false,
      rejectId: null,
      rejectNote: ''
    };
  },
  mounted() {
    this.fetchReceives();
  },
  methods: {
    async fetchReceives() {
      try {
        const response = await axios.get('/depo/product-receives');
        this.receives = response.data.data;
      } catch (error) {
        // এখানে ব্যাকস্ল্যাশ ( \ ) সরানো হয়েছে
        console.error("Error fetching data:", error); 
      }
    },
    async receiveProduct(id) {
      if (!confirm('Are you sure you want to receive these products?')) return;
      try {
        await axios.post(`/depo/product-receives/accept/${id}`);
        alert('Products received successfully!');
        this.fetchReceives();
      } catch (error) { 
        alert('Error accepting products.'); 
      }
    },
    openRejectModal(id) {
      this.rejectId = id;
      this.rejectNote = '';
      this.showRejectModal = true;
    },
    async confirmReject() {
      try {
        await axios.post(`/depo/product-receives/reject/${this.rejectId}`, { 
          reject_note: this.rejectNote 
        });
        alert('Product rejected with note.');
        this.showRejectModal = false;
        this.fetchReceives();
      } catch (error) { 
        alert('Error rejecting product.'); 
      }
    },
    statusBadge(status) {
      if (status === 'pending') return 'badge badge-warning';
      if (status === 'accepted') return 'badge badge-success';
      return 'badge badge-danger';
    }
  }
};
</script>