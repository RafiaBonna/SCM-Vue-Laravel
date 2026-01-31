<template>
    <div class="container-fluid">
        <div class="content-header">
            <h1 class="m-0 text-info">Add New Unit</h1>
        </div>
        <div class="card card-outline card-info">
            <div class="card-body">
                <form @submit.prevent="createUnit">
                    <div class="form-group">
                        <label>Unit Name (e.g. Kilogram)</label>
                        <input type="text" v-model="unit.name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Short Name (e.g. KG)</label>
                        <input type="text" v-model="unit.short_name" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-info">Save Unit</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    data() { return { unit: { name: '', short_name: '' } } },
    methods: {
        async createUnit() {
            await axios.post('admin/units', this.unit);
            this.$router.push({ name: 'unit-list' });
        }
    }
}
</script>