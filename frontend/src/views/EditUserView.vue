<script setup>
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';

const router = useRouter()
const route = useRoute()
const firstName = ref('')
const lastName = ref('')
const email = ref('')
const error = ref(null)
const success = ref(null)

onMounted(async () => {
    const token = localStorage.getItem('token')
    const res = await fetch(`/api/blog/users/${route.params.id}`, {
        headers: { 'Authorization': `Bearer ${token}` }
    })

    const user = await res.json()
    firstName.value = user.first_name
    lastName.value = user.last_name 
    email.value = user.email_address
})

async function destroy() {
    if (!confirm('Are you sure you want to delete this user?')) return
    const token = localStorage.getItem('token')
    try {
        const res = await fetch(`/api/blog/users/${route.params.id}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }

        })
        if (!res.ok) throw new Error('Failed to delete post')
        router.push('/settings/users')
        success.value = 'User updated.'
    } catch (err) {
        error.value = err.toString()
    }
}

async function submit() {
    error.value = null
    const token = localStorage.getItem('token')

    try {
        const res = await fetch(`/api/blog/users/${route.params.id}`, {
            method: 'PATCH',
            headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
            body: JSON.stringify({ user: { first_name: firstName.value, last_name: lastName.value, email_address: email.value } })
        })
        const body = await res.json()
        if(!res.ok) throw new Error(body.errors?.join(', ') || 'Failed to update user' )
        router.push('/settings/users')
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <div class="settings-section-title">Edit Users</div>

    <div v-if="success" class="auth-flash-success">{{ success }}</div>
    <div v-if="error" class="auth-flash-error">{{ error }}</div>

    <div class="article-back">
        <RouterLink to="/settings/users" class="post-read-link">
            <span class="post-read-arrow"><-</span>All users
        </RouterLink>
    </div> <br>

    <div class="settings-card">
        <div class="form-field">
            <label class="form-label">Name</label>
            <input v-model="firstName" type="text" class="form-input" />
        </div>

        <div class="form-field">
            <label class="form-label">Surname</label>
            <input v-model="lastName" type="text" class="form-input" />
        </div>

        <div class="form-field">
            <label class="form-label">Email</label>
            <input v-model="email" type="email" class="form-input" />
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="submit">Update user</button>
            <button class="btn-danger" @click="destroy">Delete user</button>
        </div>
    </div>

</template>

<style scoped></style>