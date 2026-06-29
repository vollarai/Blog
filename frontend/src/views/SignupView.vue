<script setup>
import { signup } from '@/api/auth'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
 
const error = ref(null)
const firstName = ref('')
const lastName = ref('')
const email = ref('')
const password = ref('')
const passwordConfirmation = ref('')
const router = useRouter()

async function submit() {
    error.value = null
    if (password.value !== passwordConfirmation.value) {
        error.value = 'Passwords do not match'
        return
    }
    try {
        await signup(firstName.value, lastName.value, email.value, password.value, passwordConfirmation.value)
        router.push('/')
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <div class="auth-wrapper">
        <div class="auth-card">
            <h1 class="auth-title">Create an account</h1>
            <p class="auth-subtitle">Join the blog and start writing.</p>

            <div v-if="error" class="auth-flash-error">{{ error }}</div>

            <div class="form-field">
                <label class="form-label">First Name</label>
                <input v-model="firstName" type="text" class="form-input"/>
            </div>

            <div class="form-field">
                <label class="form-label">Last Name</label>
                <input v-model="lastName" type="text" class="form-input"/>
            </div>

            <div class="form-field">
                <label class="form-label">Email</label>
                <input v-model="email" type="email" class="form-input"/>
            </div>

            <div class="form-field">
                <label class="form-label">Password</label>
                <input v-model="password" type="password" class="form-input"/>
            </div>

             <div class="form-field">
                <label class="form-label">Password Confirmation</label>
                <input v-model="passwordConfirmation" type="password" class="form-input"/>
            </div>

            <button class="btn-primary" @click="submit">Sign up</button>
            <p class="auth-footer">Already have an account?<RouterLink to="/login"> Sign in</RouterLink></p>
        </div>
    </div>
</template>

<style scoped></style>