import { createRouter, createWebHistory } from 'vue-router'
import { isLoggedIn, currentUser as authUser } from '@/api/auth'

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
import NewPostView from '@/views/NewPostView.vue'
import EditPostView from '@/views/EditPostView.vue'
import EditUserView from '@/views/EditUserView.vue'
import StatisticsView from '@/views/StatisticsView.vue'

const routes = [
  { path: '/', component: HomeView },
  { path: '/login', component: LoginView},
  { path: '/signup', component: SignupView},
  { path: '/posts/:id', component: PostView },
  { path: '/settings/', component: Settings,
    meta: { requiresAuth: true },
    redirect: '/settings/profile',
    children: [
      { path: 'profile', component: ProfileView },
      { path: 'password', component: PasswordView },
      { path: 'email', component: EmailView },
      { path: 'account', component: AccountView },
      { path: 'statistics', component: StatisticsView, meta: { requiresAdmin: true } },
      { path: 'posts', component: PostsView, meta: { requiresAdmin: true } },
      { path: 'posts/:id/edit', component: EditPostView, meta: { requiresAdmin: true } },
      { path: 'posts/new', component: NewPostView, meta: { requiresAdmin: true } },    
      { path: 'users', component: UsersView, meta: { requiresAdmin: true } },
      { path: 'users/:id/edit', component: EditUserView, meta: { requiresAdmin: true } },
      { path: 'pdfs', component: PdfsView, meta: { requiresAdmin: true } },
    ]
  },
]

export const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach((to) => {
  if (to.meta.requiresAuth && !isLoggedIn.value) return '/login'
  if (to.meta.requiresAdmin && !authUser.value?.admin) return '/settings/profile'
})