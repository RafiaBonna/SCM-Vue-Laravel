<template>
    <div class="container-fluid">
        <div class="content-header">
            <h1 class="m-0 text-info">Edit Unit</h1>
        </div>
        <div class="card card-outline card-info">
            <div class="card-body">
                <form @submit.prevent="updateUnit">
                    <div class="form-group">
                        <label>Unit Name</label>
                        <input type="text" v-model="unit.name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Short Name</label>
                        <input type="text" v-model="unit.short_name" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-info">Update Unit</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    data() { return { unit: { name: '', short_name: '' } } },
    mounted() { this.fetchUnit(); },
    methods: {
        async fetchUnit() {
            const response = await axios.get(`admin/units/${this.$route.params.id}`);
            this.unit = response.data;
        },
        async updateUnit() {
            await axios.put(`admin/units/${this.$route.params.id}`, this.unit);
            this.$router.push({ name: 'unit-list' });
        }
    }
}
</script>