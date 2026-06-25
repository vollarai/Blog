<script setup>
import { ref } from 'vue';

const stored = JSON.parse(localStorage.getItem('user') || '{}')
const password = ref(stored.password || '')
const newEmail = ref('')
const error = ref(null)
const success = ref(null)

async function update() {
    error.value = null
    success.value = null
    try {
        success.value = 'Email updated.'
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <h2 class="settings-section-title">Email</h2>

    <div v-if="success" class="auth-flash-success">{{ success }}</div>
    <div v-if="error" class="auth-flash-error">{{ error }}</div>

    <div class="setting-card">
        <div class="form-field">
            <label class="form-label">New email address</label>
            <input v-model="newEmail" type="email" class="form-input" />  
        </div>

        <div class="form-field">
            <label class="form-label">Password challenge</label>
            <input v-model="password" type="password" class="form-input" />  
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="updatePassword">Update email address</button>
        </div>
    </div>


</template>

<style scoped></style>