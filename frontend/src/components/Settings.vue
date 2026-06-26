<script setup>
import { computed } from 'vue'
import { currentUser } from '@/api/auth'

const isAdmin = computed(() => currentUser.value?.admin === true)

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
          <RouterLink to="/settings/pdfs" active-class="nav-active">Pdfs</RouterLink>
        </template>
      </nav>
    </aside>
    <div class="settings-content">
      <RouterView />
    </div>
  </div>
</template>

<style scoped></style>