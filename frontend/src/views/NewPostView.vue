<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { currentUser } from '@/api/auth'

const router = useRouter()
const title = ref('')
const content = ref('')
const imageFile = ref(null)
const error = ref(null)

async function submit() {
    error.value = null
    const token = localStorage.getItem('token')
    const formData = new FormData()
    formData.append('post[name]', currentUser.value?.name || '')
    formData.append('post[title]', title.value)
    formData.append('post[content]', content.value)
    if (imageFile.value) {
        formData.append('post[image_attributes][image]', imageFile.value)
    }

    try {
        const res = await fetch('/api/blog/posts', {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` },
            body: formData
        })
        const body = await res.json()
        if (!res.ok) throw new Error(body.errors?.join(', ') || 'Failed to create post')
        router.push('/settings/posts')
    } catch (err) {
        error.value = err.toString()
    }
}
</script>

<template>
    <h2 class="settings-section-title">New Post</h2>

    <div class="article-back">
        <RouterLink to="/settings/posts" class="post-read-link">
            <span class="post-read-arrow"><-</span>All posts
        </RouterLink>
    </div> <br>
    
    <div v-if="error" class="auth-flash-error">{{ error }}</div>

    <div class="settings-card">
        <div class="form-field">
            <label class="form-label">Title</label>
            <input v-model="title" type="text" class="form-input"/>
        </div>

        <div class="form-field">
            <label class="form-label">Content</label>
            <textarea v-model="content" rows="10" class="form-textarea"></textarea>
        </div>

        <div class="form-field">
            <input type="file" accept="image/*" @change="imageFile = $event.target.files[0]" class="form-input"/>
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="submit">Save post</button>
        </div>
    </div>
</template>

<style scoped>
</style>