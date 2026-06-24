<script setup>
import { onMounted, ref, watch, computed } from 'vue'
import { useRoute } from 'vue-router'
import { fetchPosts } from '@/api/posts'
import { router } from '@/router'

const route = useRoute()

const loading = ref(false)
const posts = ref(null)
const error = ref(null)
const currentPage = ref(1)
const totalPages = ref(1)

async function fetchData(page) {
  error.value = null
  loading.value = true

  try{
    const data = await fetchPosts(page)
    posts.value = data.posts
    totalPages.value = data.meta.total_pages
  } catch (err) {
    error.value = err.toString()
  } finally {
    loading.value = false
  } 
}

function formatDate(dateStr) {
  return new Date(dateStr).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}

onMounted (() => fetchData(1))
watch(currentPage, (page) => fetchData(page))

const pages = computed(() =>
  Array.from({ length: totalPages.value }, (_, i) => i + 1)
)

</script>

<template>
  <section class="hero">
    <h1 class="hero-headline">
    Ideas that matter,<br>
    <span class="hero-gradient">moving at the right pace.</span>
  </h1>
  <p class="hero-subtext">
    A high-signal space for thoughtful essays on culture, technology, and the art of living deliberately.
  </p>
  </section>

  <main class="posts-main">
    <div class="posts-header">
      <span class="posts-label">Latest Writings</span>
    </div>

    <div v-if="loading" class="loading">Loading...</div>
    <div v-if="error" class="error">{{ error }}</div>

    <div v-if="posts" class="posts-list">
      <article class="post-card" v-for="post in posts" :key="post.id">
        <img v-if="post.image_url" :src="post.image_url" :alt="post.title" class="post-card-image" />
        <div class="post-meta">
          <span class="post-author">{{ post.name }}</span>
          <span>·</span>
          <data>{{ formatDate(post.created_at) }}</data>
        </div>
        <h2 class="post-title">{{ post.title }}</h2>
        <p class="post-excerpt">{{ post.content }}</p>
        <RouterLink :to="`/posts/${post.id}`" class="post-read-link">
          Read more <span class="post-read-arrow">-></span>
        </RouterLink>
      </article>
    </div>

    <div class="paginate">
      <button :disabled="currentPage === 1" @click="currentPage--"><<</button>
      <button v-for="page in pages" :key="page" @click="currentPage = page" :class="{ active: page === currentPage }">
        {{ page }}
      </button>
      <button :disabled="currentPage === totalPages" @click="currentPage++">>></button>
    </div>
  </main>
</template>

<style scoped>

</style>
