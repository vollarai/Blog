<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

// const isLogged = computed(() => !!localStorage.getItem('token'))

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
                <RouterLink v-if="isLoggedIn" to="/settings" active-class="nav-active">Settings</RouterLink>
            </nav>
        </div>
    </header>
</template>

<style scoped>
    /* .site-header {
    position: sticky;
    top: 0;
    z-index: 50;
    border-bottom: 1px solid #222;
    background-color: #0f0f0f;
    backdrop-filter: blur(12px);
    }

    .header-inner {
    max-width: 900px;
    margin: 0 auto;
    padding: 0 24px;
    height: 64px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    }

    .header-brand {
    display: flex;
    align-items: center;
    gap: 8px;
    }

    .brand-icon {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    background-color: #6366f1;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    color: white;
    }

    .brand-name {
    font-weight: 700;
    font-size: 20px;
    color: white;
    }

    nav.navbar {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-size: 0.875em;
    }

    nav.navbar form {
    display: inline;
    }

    nav.navbar a,
    nav.navbar button {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 6px;
    color: #a1a1aa;
    background: none;
    border: none;
    font: inherit;
    line-height: normal;
    cursor: pointer;
    }

    nav.navbar a:hover,
    nav.navbar button:hover {
    color: white;
    }

    nav.navbar a:hover,
    nav.navbar button:active {
    background-color: #4f46e5;
    color: white;
    }

    nav.navbar a.nav-active {
    background-color: #6366f1;
    color: white;
    } */
</style>