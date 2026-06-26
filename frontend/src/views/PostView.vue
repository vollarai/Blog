<script setup>
import { fetchPost } from '@/api/posts'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { fetchComments, createComment } from '@/api/comments'
import { isLoggedIn } from '@/api/auth'
const route = useRoute()
const loading = ref(false)
const post = ref(null)
const error = ref(null)
const comments = ref([])
const commentError = ref(null)
const commentBody = ref('')

async function fetchData(id) {
    error.value = null 
    loading.value = true

    try{
        post.value = await fetchPost(id)
    } catch (err) {
        error.value = err.toString()
    } finally {
        loading.value = false
    }
}

async function loadComments() {
  comments.value = await fetchComments(route.params.id)
}

async function submitComment() {
  commentError.value = null
  try {
    const c = await createComment(route.params.id, commentBody.value)
    comments.value.push(c)
    commentBody.value = ''
  } catch (err) {
    commentError.value = err.toString()
  }
}

onMounted(() => {
  fetchData(route.params.id)
  loadComments()
})

function formatDate(dateStr) {
  return new Date(dateStr).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}
</script>

<template>
    <main class="article-main">
        <div class="article-back">
            <RouterLink to="/" class="post-read-link"><span class="post-read-arrow"><-</span>All essays</RouterLink>
        </div>

        <div v-if="loading" class="loading">Loading...</div>
        <div v-if="error" class="error">{{ error }}</div>

        <article v-if="post" class="article-body">
            <div class="article-meta">
                <span class="post-author">{{ post.name }}</span>
                <span>·</span>
                <data>{{ formatDate(post.created_at) }}</data>
            </div>

            <h1 class="article-title">{{ post.title }}</h1>
            <div v-if="post.image_url" class="article-image">
                <img :src="post.image_url" :alt="post.title" />
            </div>

            <div class="article-content">{{ post.content }}</div>
        </article>

        <section class="article-comments">
            <h2 class="comments-heading">Comments</h2>

            <div v-if="comments.length === 0" class="comments-empty">No comments yet.</div>

            <div class="comments-list">
                <div class="comment" v-for="c in comments" :key="c.id">
                <div class="comment-author">{{ c.author }}</div>
                <p class="comment-body">{{ c.body }}</p>
                </div>
            </div>

            <div v-if="isLoggedIn" class="comment-form-wrapper">
                <p class="comment-form-heading">Leave a comment</p>
                <div v-if="commentError" class="form-error">{{ commentError }}</div>
                <textarea v-model="commentBody" rows="4" placeholder="Write a comment..."></textarea>
                <input type="submit" value="Post comment" @click="submitComment" />
            </div>
            <p v-else class="comments-login">
                <RouterLink to="/login">Log in</RouterLink> to leave a comment.
            </p>
        </section>

    </main>

</template>

<style scoped> </style>