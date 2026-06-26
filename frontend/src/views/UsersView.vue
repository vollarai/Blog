<script setup>
import { adminFetchUsers } from '@/api/users';
import { ref, onMounted, watch, computed } from 'vue';

const error = ref(null)
const users = ref(null)
const loading = ref(false)
const currentPage = ref(1)
const totalPages = ref(1)

async function fetchData(page) {
    error.value = null
    loading.value = true

    try {
        const data = await adminFetchUsers(page)
        users.value = data.users
        totalPages.value = data.meta.total_pages
    } catch (err) {
        error.value = err.toString()
    } finally {
        loading.value = false
    }
}

onMounted (() => fetchData(1))
watch(currentPage, (page) => fetchData(page))

const pages = computed(() =>
  Array.from({ length: totalPages.value }, (_, i) => i + 1)
)

</script>

<template>
    <div class="admin-header">
        <h1 class="admin-title">Users</h1>
    </div>

    <div v-if="loading" class="loading">Loading...</div>
    <div v-if="error" class="error">{{ error }}</div>

    <div v-if="users" class="admin-list">
        <div class="admin-card" v-for="user in users" :key="user.id">
            <div class="admin-card-title">{{ user.first_name }} {{ user.last_name }}</div>
            
            <div class="admin-card-action">
                <RouterLink :to="`/settings/users/${user.id}/edit`" class="btn-secondary">Edit</RouterLink>
            </div>
        </div>
    </div>
</template>

<style scoped>
</style>