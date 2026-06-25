<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { updateProfile } from '@/api/auth'

const router = useRouter() 
const stored = JSON.parse(localStorage.getItem('user') || '{}')
const firstName = ref(stored.first_name || '')
const lastName = ref(stored.last_name || '')
const error = ref(null)
const success = ref(null)

async function update() {
    error.value = null
    success.value = null
    try {
        const data = await updateProfile(firstName.value, lastName.value)
        localStorage.setItem('user', JSON.stringify(data.user))
        success.value = 'Profile updated.'
    } catch (err) {
        error.value = err.toString()
    }
}

</script>

<template>
    <h2 class="settings-section-title">Profile</h2>

    <div v-if="success" class="auth-flash-success">{{ success }}</div>
    <div v-if="error" class="auth-flash-error">{{ error }}</div>

    <div class="setting-card">
        <div class="form-field">
            <label class="form-label">First Name</label>
            <input v-model="firstName" type="text" class="form-input" />  
        </div>

        <div class="form-field">
            <label class="form-label">Last Name</label>
            <input v-model="lastName" type="text" class="form-input" />  
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="updateProfile">Update profile</button>
        </div>
    </div>
</template>

<style scoped></style>