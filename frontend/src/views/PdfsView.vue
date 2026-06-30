<script setup>
import { ref, onMounted, watch, computed } from 'vue'

const error = ref(null)
const pdfs = ref([])
const currentPage = ref(1)
const totalPages = ref(1)
const token = localStorage.getItem('token')

async function fetchData(page) {
    error.value = null
    try {
        const res = await fetch(`/api/blog/pdfs?page=${page}`, {
            headers: { 'Authorization': `Bearer ${token}` } 
        })
        if (!res.ok) throw new Error('Failed to load PDFs')
        const data = await res.json()
        pdfs.value = data.pdfs
        totalPages.value = data.meta.total_pages
    } catch (err) {
        error.value = err.toString()
    }  
}

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

onMounted(() => fetchData(1))
watch(currentPage, (page) => fetchData(page))

async function downloadPdf(pdf) {
  try {
    const res = await fetch(`/api/blog/pdfs/${pdf.id}`, {
      headers: { 'Authorization': `Bearer ${token}` }
    })
    if (!res.ok) throw new Error('Download failed')
    const blob = await res.blob()
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = pdf.filename
    a.click()
    URL.revokeObjectURL(url)
  } catch (err) {
    error.value = err.toString()
  }
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

    <div v-if="totalPages > 1" class="paginate">
        <button :disabled="currentPage === 1" @click="currentPage--"><<</button>
        <button v-for="page in pages" :key="page" @click="currentPage = page" :class="{ active: page === currentPage }">
            {{ page }}
        </button>
        <button :disabled="currentPage === totalPages" @click="currentPage++">>></button>
    </div>

</template>

<style scoped>
</style>
