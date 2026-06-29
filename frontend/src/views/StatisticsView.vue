<script setup>
import { ref, computed, onMounted, watch } from 'vue'

const stats = ref(null)
const error = ref(null)
const currentPage = ref(1)
const totalPages = ref(1)
const loading = ref(null)
const token = localStorage.getItem('token')

const popular = computed(() => stats.value?.popular_posts ?? [])

async function fetchData(page) {
    error.value = null
    loading.value = true

    try {
        const res = await fetch(`/api/blog/statistics?page=${page}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        })
        if (!res.ok) throw new Error('Failed to load statistics')
        const data = await res.json()
        stats.value = data
        totalPages.value = data.meta.total_pages
    } catch (err) {
        error.value = err.toString()
    } finally {
        loading.value = false
    }  
}

onMounted(() => fetchData(1))
watch(currentPage, (page) => fetchData(page))

const pages = computed(() => {
    const range = 2
    const start = Math.max(2, currentPage.value - range)
    const end = Math.min(totalPages.value - 1, currentPage.value + range)
    const middle = Array.from({ length: Math.max(0, end - start + 1) }, (_, i) => start + i)

    const result = []
    result.push(1)
    if (start > 2) result.push('...')
    result.push(...middle)
    if (end < totalPages.value - 1) result.push('...')
    if (totalPages.value > 1) result.push(totalPages.value)
    return result
})

</script>

<template>
    <h2 class="settings-section-title">Statistics</h2>
    <div v-if="error" class="error">{{ error }}</div>
    <div v-if="stats">
        <h2 class="admin-card-title-a">Most popular</h2>
        
        <div class="admin-list">
            <div class="admin-card" v-for="post in stats.popular_posts" :key="post.id">
                <div>
                    <div class="admin-card-title">{{ post.title }}</div>
                    <div class="admin-card-meta">{{ post.comment_count }} comments</div>
                </div>
                <div class="admin-card-action">
                    <RouterLink :to="`/posts/${post.id}`" class="btn-secondary">View</RouterLink>
                </div>
            </div>

            <div v-if="popular.length === 0" class="comments-empty">No posts yet.</div>
        </div>

        <h2 class="admin-card-title-a">All posts</h2>
        <div class="admin-list">
            <div class="admin-card" v-for="post in stats.posts" :key="post.id">
                <div>
                    <div class="admin-card-title">{{ post.title }}</div>
                    <div class="admin-card-meta">{{ post.comment_count }} comments</div>
                </div>
                <div class="admin-card-action">
                    <RouterLink :to="`/posts/${post.id}`" class="btn-secondary">View</RouterLink>
                </div>
            </div>
            <div v-if="stats.posts.length === 0" class="comments-empty">No posts yet.</div>
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
    .admin-card-title-a{
        font-size: 15px;
        font-weight: 600;
        color: white;
        margin: 15px;
    }
</style>
