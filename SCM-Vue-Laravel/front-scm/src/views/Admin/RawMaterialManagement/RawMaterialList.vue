<template>
  <div class="container-fluid">
    <div class="content-header">
      <h1 class="m-0 text-info">Raw Material Master List</h1>
    </div>

    <section class="content">
      <div class="row mb-3">
        <div class="col-12">
          <router-link
            :to="{ name: 'raw-material-create' }"
            class="btn btn-info float-right"
          >
            <i class="fas fa-plus-circle"></i> Add New Material
          </router-link>
        </div>
      </div>

      <div class="card card-outline card-info">
        <div class="card-body p-0">
          <table class="table table-striped table-hover">
            <thead>
              <tr>
                <th>#</th>
                <th>Material Name</th>
                <th>Basic Unit</th>
                <th>Alert Stock</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in rawMaterials" :key="item.id">
                <td>{{ index + 1 }}</td>
                <td>{{ item.name }}</td>
                <td>{{ item.unit ? item.unit.name : "N/A" }}</td>
                <td>{{ item.alert_stock }}</td>
                <td>
                  <!-- Edit Button with router-link -->
                  <router-link
                    :to="{ name: 'raw-material-edit', params: { id: item.id } }"
                    class="btn btn-sm btn-primary mr-1"
                  >
                    <i class="fas fa-edit"></i>
                  </router-link>

                  <!-- Delete Button -->
                  <button
                    @click="deleteMaterial(item.id)"
                    class="btn btn-sm btn-danger"
                  >
                    <i class="fas fa-trash"></i>
                  </button>
                </td>
              </tr>
              <tr v-if="rawMaterials.length === 0">
                <td colspan="5" class="text-center">
                  No raw materials found in master list.
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
      rawMaterials: [],
    };
  },
  mounted() {
    this.fetchRawMaterials();
  },
  methods: {
    async fetchRawMaterials() {
      try {
        const response = await axios.get("admin/raw-materials");
        this.rawMaterials = response.data;
      } catch (error) {
        console.error("Error fetching raw materials", error);
      }
    },
    async deleteMaterial(id) {
      if (confirm("Are you sure you want to delete this material?")) {
        await axios.delete(`admin/raw-materials/${id}`);
        this.fetchRawMaterials();
      }
    },
  },
};
</script>
