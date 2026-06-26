<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { deleteAccount } from '@/api/auth'

const router = useRouter()
const error = ref(null)

async function destroy() {
    if (!confirm('Are you sure? This will permanently delete your account and cannot be undone.')) return
    error.value = null
    try {
        await deleteAccount()
        localStorage.removeItem('token')
        localStorage.removeItem('user')
        router.push('/login')
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <div class="settings-card">
        <h2 class="settings-section-title">Account</h2>
        <div v-if="error" class="auth-flash-error">{{ error }}</div>
        <p class="a_del">Permanently delete your account and all associated data. This action cannot be undone.</p>
        <button class="btn-danger" @click="destroy">Delete my account</button>
    </div>
</template>

<style scoped>
    .a_del {
        font-size: 14px;
        color: #a1a1aa;
        margin-bottom: 24px;
    }
</style>
