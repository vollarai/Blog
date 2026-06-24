import { createRouter, createWebHistory } from 'vue-router'

import HomeView from '@/views/HomeView.vue'
import LoginView from '@/views/LoginView.vue'
import SignupView from '@/views/SignupView.vue'
import PostView from '@/views/PostView.vue'
import SettingsView from '@/views/SettingsView.vue'

const routes = [
  { path: '/', component: HomeView },
  { path: '/login', component: LoginView},
  { path: '/signup', component: SignupView},
  { path: '/posts/:id', component: PostView },
  { path: '/settings', component: SettingsView},
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})