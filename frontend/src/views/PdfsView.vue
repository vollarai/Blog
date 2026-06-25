<script setup>
import { ref } from 'vue';

const error = ref(null)
const pdfs = ref(null)

async function fetchData() {
    error.value = null
    try {

    } catch (err) {
        error.value = err.toString()
    }  
}

</script>

<template> 
    <div class="admin-header">
        <h1 class="admin-title">PDFs</h1>
    </div>
</template>

<style scoped>
</style>