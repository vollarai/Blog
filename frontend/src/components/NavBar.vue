<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

//const isLogged = computed(() => !!localStorage.getItem('token'))

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
                <RouterLink to="/login" active-class="nav-active">Login</RouterLink>
                <RouterLink to="/signup" active-class="nav-active">Sign Up</RouterLink>
                <RouterLink to="/settings" active-class="nav-active" router-link-exact-active>Settings</RouterLink>
            </nav>
        </div>
    </header>
</template>

<style scoped></style>