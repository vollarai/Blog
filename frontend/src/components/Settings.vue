<script setup></script>

<template>
  <div class="settings-layout">
    <aside class="settings-sidebar">
      <p class="settings-sidebar-title">Settings</p>
      <nav>
        <RouterLink to="/settings/profile" active-class="nav-active">Profile</RouterLink>
        <RouterLink to="/settings/password" active-class="nav-active">Password</RouterLink>
        <RouterLink to="/settings/email" active-class="nav-active">Email</RouterLink>
        <RouterLink to="/settings/account" active-class="nav-active">Account</RouterLink>
        <RouterLink to="/settings/posts" active-class="nav-active">Posts</RouterLink>
        <RouterLink to="/settings/users" active-class="nav-active">Users</RouterLink>
        <RouterLink to="/settings/pdfs" active-class="nav-active">Pdfs</RouterLink>
      </nav>
    </aside>
    <div class="settings-content">
      <RouterView />  
    </div>
  </div>
</template>

<style scoped></style>