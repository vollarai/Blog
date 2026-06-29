<script setup>
import { currentUser } from '@/api/auth';
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';

const router = useRouter()
const route = useRoute()
const error = ref(null)
const title = ref('')
const content = ref('')
const imageFile = ref(null)
const existingImage = ref(null)

onMounted(async () => {
    const token = localStorage.getItem('token')
    const res = await fetch(`/api/blog/posts/${route.params.id}`, {
        headers: { 'Authorization': `Bearer ${token}` }
    })

    const post = await res.json()
    title.value = post.title
    content.value = post.content 
    existingImage.value = post.image_url
})

async function destroy() {
    if (!confirm('Are you sure you want to delete this post?')) return
    const token = localStorage.getItem('token')
    try {
        const res = await fetch(`/api/blog/posts/${route.params.id}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        })
        if (!res.ok) throw new Error('Failed to delete post')
        router.push('/settings/posts')
    } catch (err) {
        error.value = err.toString()
    }
}

async function submit() {
    error.value = null
    const token = localStorage.getItem('token')
    const data = new FormData()
    data.append('post[name]', currentUser.value?.name || '')
    data.append('post[title]', title.value)
    data.append('post[content]', content.value)

    if(imageFile.value) {
        data.append('post[image_attributes][image]', imageFile.value)
    }

    try {
        const res = await fetch(`/api/blog/posts/${route.params.id}`, {
            method: 'PATCH',
            headers: { 'Authorization': `Bearer ${token}` },
            body: data
        })
        const body = await res.json()
        if(!res.ok) throw new Error(body.errors?.join(', ') || 'Failed to update post' )
        router.push('/settings/posts')
    } catch (err) {
        error.value = err.toString()
    }
}

</script>

<template>
    <div class="settings-section-title">Edit Post</div>

    <div class="article-back">
        <RouterLink to="/settings/posts" class="post-read-link">
            <span class="post-read-arrow"><-</span>All posts
        </RouterLink>
    </div> <br>

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
            <img v-if="existingImage" :src="existingImage" class="img" />
            <input type="file" accept="image/*" @change="imageFile = $event.target.files[0]" class="form-input"/>
        </div>

        <div class="form-actions">
            <button class="btn-primary" @click="submit">Update post</button>
            <button class="btn-danger" @click="destroy">Delete post</button>
        </div>
    </div>
</template>

<style scoped>
    .img{
        height:60px;
        margin-bottom:8px; 
        border-radius:6px;
    }

</style>