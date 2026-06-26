<script setup>
import { ref } from 'vue'
import { updateEmail } from '@/api/auth'

const newEmail = ref('')
const password = ref('')
const error = ref(null)
const success = ref(null)

async function update() {
    error.value = null
    success.value = null
    try {
        const data = await updateEmail(newEmail.value, password.value)
        success.value = data.message
        newEmail.value = ''
        password.value = ''
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <h2 class="settings-section-title">Email</h2>

    <div v-if="success" class="auth-flash-success">{{ success }}</div>
    <div v-if="error" class="auth-flash-error">{{ error }}</div>

    <div class="settings-card">
        <div class="form-field">
            <label class="form-label">New email address</label>
            <input v-model="newEmail" type="email" class="form-input" />
        </div>

        <div class="form-field">
            <label class="form-label">Current password</label>
            <input v-model="password" type="password" class="form-input" />
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="update">Update email address</button>
        </div>
    </div>
</template>

<style scoped></style>
