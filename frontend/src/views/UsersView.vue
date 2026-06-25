<script setup>
import { ref } from 'vue';

const error = ref(null)
const users = ref(null)

async function fetchData() {
    error.value = null
    try {
        const data = await fetchData()
        users.value = data.users

    } catch (err) {
        error.value = err.toString()
    }  
}

</script>

<template>
    <div class="admin-header">
        <h1 class="admin-title">Users</h1>
    </div>

</template>

<style scoped>
</style>