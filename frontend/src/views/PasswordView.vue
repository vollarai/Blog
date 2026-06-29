<script setup>
import { ref } from 'vue';
import { updatePassword } from '@/api/auth'

const currentPassword = ref('')
const newPassword = ref('')
const passwordConfirmation = ref('')
const error = ref(null)
const success = ref(null)

async function update() {
    error.value = null
    success.value = null
    if (newPassword.value !== passwordConfirmation.value) {
        error.value = 'New passwords do not match'
        return
    }
    try {
        await updatePassword(currentPassword.value, newPassword.value, passwordConfirmation.value)
        success.value = 'Password updated.'
        currentPassword.value = ''
        newPassword.value = ''
        passwordConfirmation.value = ''
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <h2 class="settings-section-title">Password</h2>

    <div v-if="success" class="auth-flash-success">{{ success }}</div>
    <div v-if="error" class="auth-flash-error">{{ error }}</div>

    <div class="settings-card">
        <div class="form-field">
            <label class="form-label">Current password</label>
            <input v-model="currentPassword" type="password" class="form-input" />
        </div>

        <div class="form-field">
            <label class="form-label">New password</label>
            <input v-model="newPassword" type="password" class="form-input" />
        </div>

        <div class="form-field">
            <label class="form-label">Confirm new password</label>
            <input v-model="passwordConfirmation" type="password" class="form-input" />
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="update">Update password</button>
        </div>
    </div>
</template>

<style scoped></style>
