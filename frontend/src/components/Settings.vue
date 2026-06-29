<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import { currentUser } from '@/api/auth'

const route = useRoute()
const isAdmin = computed(() => currentUser.value?.admin === true)
const hasPdfs = ref(false)

onMounted(async () => {
  if (!isAdmin.value) return
  const token = localStorage.getItem('token')
  const res = await fetch('/api/blog/pdfs', { headers: { 'Authorization': `Bearer ${token}` } })
  if (res.ok) {
    const data = await res.json()
    hasPdfs.value = data.pdfs.length > 0
  }
})

</script>

<template>
  <div class="settings-layout">
    <aside class="settings-sidebar">
      <p class="settings-sidebar-title">Settings</p>
      <nav>
        <RouterLink to="/settings/profile" active-class="nav-active">Profile</RouterLink>
        <RouterLink to="/settings/password" active-class="nav-active">Password</RouterLink>
        <RouterLink to="/settings/email" active-class="nav-active">Email</RouterLink>
        <RouterLink to="/settings/account" active-class="nav-active">Account</RouterLink>
        <template v-if="isAdmin">
          <RouterLink to="/settings/posts" active-class="nav-active">Posts</RouterLink>
          <RouterLink to="/settings/users" active-class="nav-active">Users</RouterLink>
          <RouterLink v-if="hasPdfs" to="/settings/pdfs" active-class="nav-active">Pdfs</RouterLink>
        </template>
      </nav>
    </aside>
    <div class="settings-content">
      <RouterView />
    </div>
  </div>
</template>

<style scoped></style>