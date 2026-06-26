<script setup>
import { ref, onMounted } from 'vue'

const error = ref(null)
const pdfs = ref([])

onMounted(async () => {
    error.value = null
    const token = localStorage.getItem('token')
    try {
        const res = await fetch('/api/blog/pdfs', { headers: { 'Authorization': `Bearer ${token}` } })
        if (!res.ok) throw new Error('Failed to load PDFs')
        const data = await res.json()
        pdfs.value = data.pdfs
    } catch (err) {
        error.value = err.toString()
    }
})

async function downloadPdf(pdf) {
}

</script>

<template>
    <div class="admin-header">
        <h1 class="admin-title">PDFs</h1>
    </div>

    <div v-if="error" class="error">{{ error }}</div>

    <div class="admin-list">
        <div class="admin-card" v-for="pdf in pdfs" :key="pdf.id">
            <div>
                <div class="admin-card-title">{{ pdf.filename }}</div>
                <div class="admin-card-meta">{{ pdf.post_title }} · {{ pdf.status }}</div>
            </div>
            <div class="admin-card-action">
                <button v-if="pdf.downloadable" class="btn-secondary" @click="downloadPdf(pdf)">Download</button>
            </div>
        </div>
        <div v-if="pdfs.length === 0" class="comments-empty">No PDFs yet.</div>
    </div>
</template>

<style scoped>
</style>
