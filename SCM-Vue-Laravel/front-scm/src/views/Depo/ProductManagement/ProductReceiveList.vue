<template>
  <div class="container-fluid">
    <!-- Header -->
    <div class="content-header d-flex justify-content-between align-items-center mb-3">
      <h1 class="m-0 text-success">
        <i class="fas fa-truck-loading mr-2"></i> Product Receive List (From Admin)
      </h1>
    </div>

    <!-- Content -->
    <section class="content">
      <div class="card card-outline card-success">
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-bordered table-hover mb-0">
              <thead class="thead-light">
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
                  <td><b>{{ item.invoice_no }}</b></td>
                  <td>{{ item.total_amount }}</td>
                  <td>
                    <span :class="statusBadge(item.status)">
                      {{ item.status.toUpperCase() }}
                    </span>
                  </td>
                  <td class="text-center">
                    <router-link
                      :to="{ name: 'depo-receive-invoice', params: { id: item.id } }"
                      class="btn btn-sm btn-info mr-1"
                    >
                      <i class="fas fa-eye"></i> View
                    </router-link>

                    <template v-if="item.status === 'pending'">
                      <button
                        @click="receiveProduct(item.id)"
                        class="btn btn-sm btn-success mr-1"
                      >
                        <i class="fas fa-check-circle"></i> Receive
                      </button>

                      <button
                        @click="openRejectModal(item.id)"
                        class="btn btn-sm btn-danger"
                      >
                        <i class="fas fa-times-circle"></i> Reject
                      </button>
                    </template>

                    <span v-else class="badge badge-light border text-muted ml-1">
                      Processed
                    </span>
                  </td>
                </tr>

                <tr v-if="receives.length === 0">
                  <td colspan="5" class="text-center text-muted py-3">
                    No product receive records found.
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </section>

    <!-- Reject Modal -->
    <div v-if="showRejectModal" class="modal d-block" style="background: rgba(0,0,0,0.5)">
      <div class="modal-dialog modal-md">
        <div class="modal-content shadow-lg">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title">
              <i class="fas fa-times-circle mr-2"></i> Reject Products
            </h5>
            <button type="button" class="close text-white" @click="showRejectModal = false">
              &times;
            </button>
          </div>

          <div class="modal-body">
            <label class="font-weight-bold">Reason for rejection</label>
            <textarea
              v-model="rejectNote"
              class="form-control"
              rows="3"
              placeholder="Explain why you are rejecting..."
            ></textarea>
          </div>

          <div class="modal-footer">
            <button class="btn btn-secondary" @click="showRejectModal = false">
              Cancel
            </button>
            <button
              class="btn btn-danger"
              @click="confirmReject"
              :disabled="!rejectNote"
            >
              Confirm Reject
            </button>
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
        console.error("Error fetching data:", error);
        alert('Failed to load receive records.');
      }
    },

    async receiveProduct(id) {
      if (!confirm('Are you sure you want to receive these products?')) return;
      try {
        await axios.post(`/depo/product-receives/accept/${id}`);
        alert('Products received successfully!');
        this.fetchReceives();
      } catch (error) {
        console.error("Receive Error:", error);
        alert('Failed to receive product.');
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
            // এই কি (Key) টি যেন কন্ট্রোলারের $request->reject_note এর সাথে মিলে
            reject_note: this.rejectNote 
        });
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

<style scoped>
.table td,
.table th {
  vertical-align: middle;
}

.modal .modal-content {
  border-radius: 8px;
}
</style>
