<template>
    <div class="container-fluid">
        <div class="content-header">
            <h1 class="m-0 text-info">Raw Material Unit List</h1>
        </div>
        <section class="content">
            <div class="row mb-3">
                <div class="col-12">
                   <router-link :to="{ name: 'unit-create' }" class="btn btn-info float-right">
                        <i class="fas fa-plus-circle"></i> Add New Unit
                    </router-link>
                </div>
            </div>
            <div class="card card-outline card-info">
                <div class="card-body p-0">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Unit Name</th>
                                <th>Short Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(unit, index) in units" :key="unit.id">
                                <td>{{ index + 1 }}</td>
                                <td>{{ unit.name }}</td>
                                <td>{{ unit.short_name }}</td>
                                <td>
                                    <router-link :to="{ name: 'unit-edit', params: { id: unit.id } }" class="btn btn-sm btn-primary mr-1">
                                        <i class="fas fa-edit"></i>
                                    </router-link>
                                    <button @click="deleteUnit(unit.id)" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i>
                                    </button>
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
import axios from 'axios';
export default {
    data() { return { units: [] } },
    mounted() { this.fetchUnits(); },
    methods: {
        async fetchUnits() {
            const response = await axios.get('admin/units');
            this.units = response.data;
        },
        async deleteUnit(id) {
            if(confirm('Are you sure?')) {
                await axios.delete(`admin/units/${id}`);
                this.fetchUnits();
            }
        }
    }
}
</script>