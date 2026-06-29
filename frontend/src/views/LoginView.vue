<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { login } from '@/api/auth'

const router = useRouter()
const email = ref('')
const password = ref('')
const error = ref(null)

async function submit() {
  error.value = null
  try {
    await login(email.value, password.value)
    router.push('/')
  } catch (err) {
    error.value = err.toString()
  }
}
</script>

<template>
  <div class="auth-wrapper">
    <div class="auth-card">
      <h1 class="auth-title">Welcome back</h1>
      <p class="auth-subtitle">Sign in to your account</p>
      <div v-if="error" class="auth-flash-error">{{ error }}</div>
      <div class="form-field">
        <label class="form-label">Email</label>
        <input v-model="email" type="email" class="form-input" />
      </div>
      <div class="form-field">
        <label class="form-label">Password</label>
        <input v-model="password" type="password" class="form-input" />
      </div>
      <button class="btn-primary" @click="submit">Sign in</button>
      <p class="auth-footer">No account? <RouterLink to="/signup">Sign up</RouterLink></p>
    </div>
  </div>
</template>
