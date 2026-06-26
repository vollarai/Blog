<script setup>
import { adminFetchPosts } from '@/api/posts'
import { ref, onMounted, watch, computed } from 'vue'

const loading = ref(false)
const posts = ref(null)
const error = ref(null)
const currentPage = ref(1)
const totalPages = ref(1)

async function fetchData(page) {
    error.value = null
    loading.value = true

    try {
        const data = await adminFetchPosts(page)
        posts.value = data.posts
        totalPages.value = data.meta.total_pages
    } catch (err) {
        error.value = err.toString()
    } finally {
        loading.value = false
    }  
}

onMounted (() => fetchData(1))
watch(currentPage, (page) => fetchData(page))

const pages = computed(() =>
  Array.from({ length: totalPages.value }, (_, i) => i + 1)
)

</script>

<template>
    <div class="admin-header"> 
        <h1 class="admin-title">Posts</h1>
        <RouterLink to="/settings/posts/new" class="btn-primary">New post</RouterLink>
    </div>

    <div v-if="loading" class="loading">Loading...</div>
    <div v-if="error" class="error">{{ error }}</div>

    <div v-if="posts" class="admin-list">
        <div class="admin-card" v-for="post in posts" :key="post.id">
            <div class="admin-card-title">{{ post.title }}</div>
            <div class="admin-card-meta"> by {{ post.name }}</div>

            <div class="admin-card-action">
                <RouterLink :to="`/posts/${post.id}`" class="btn-secondary">View</RouterLink>
                <RouterLink :to="`/settings/posts/${post.id}/edit`" class="btn-secondary">Edit</RouterLink>
            </div>
        </div>

        <div v-if="totalPages > 1" class="paginate">
            <button :disabled="currentPage === 1" @click="currentPage--"><<</button>
                <button v-for="page in pages" :key="page" @click="currentPage = page" :class="{ active: page === currentPage }">
                    {{ page }}
                </button>
            <button :disabled="currentPage === totalPages" @click="currentPage++">>></button>
        </div>
    </div>


</template>

<style scoped>
    .btn-secondary{
        margin-left: 20px;
    }
</style>