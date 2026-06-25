import { createRouter, createWebHistory } from 'vue-router'

import HomeView from '@/views/HomeView.vue'
import LoginView from '@/views/LoginView.vue'
import SignupView from '@/views/SignupView.vue'
import PostView from '@/views/PostView.vue'
import Settings from '@/components/Settings.vue'
import ProfileView from '@/views/ProfileView.vue'
import PasswordView from '@/views/PasswordView.vue'
import EmailView from '@/views/EmailView.vue'
import PostsView from '@/views/PostsView.vue'
import AccountView from '@/views/AccountView.vue'
import UsersView from '@/views/UsersView.vue'
import PdfsView from '@/views/PdfsView.vue'

const routes = [
  { path: '/', component: HomeView },
  { path: '/login', component: LoginView},
  { path: '/signup', component: SignupView},
  { path: '/posts/:id', component: PostView },
  { path: '/settings/', component: Settings,
    children: [
      { path: 'profile', component: ProfileView },
      { path: 'password', component: PasswordView },
      { path: 'email', component: EmailView },
      { path: 'account', component: AccountView },
      { path: 'posts', component: PostsView },
      { path: 'users', component: UsersView },
      { path: 'pdfs', component: PdfsView },
    ]
  },
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})