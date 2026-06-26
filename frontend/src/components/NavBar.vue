<script setup>
import { useRouter } from 'vue-router'
import { isLoggedIn, clearAuth } from '@/api/auth'

const router = useRouter()

function logout() {
    clearAuth()
    router.push('/login')
}
</script>

<template>
    <header class="site-header">
        <div class="header-inner">
            <div class="header-brand">
                <div class="brand-icon">B</div>
                <span class="brand-name">Blog</span>
            </div>

            <nav class="navbar">
                <RouterLink to="/" active-class="nav-active">Home</RouterLink>
                <template v-if="isLoggedIn">
                    <RouterLink to="/settings" active-class="nav-active">Settings</RouterLink>
                    <button class="nav-logout" @click="logout">Log out</button>
                </template>
                <template v-else>
                    <RouterLink to="/login" active-class="nav-active">Login</RouterLink>
                    <RouterLink to="/signup" active-class="nav-active">Sign Up</RouterLink>
                </template>
            </nav>
        </div>
    </header>
</template>

<style scoped></style>