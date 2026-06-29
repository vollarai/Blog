const API = '/api'

function authHeaders() {
  const token = localStorage.getItem('token')
  return token ? { 'Authorization': `Bearer ${token}` } : {}
}

export async function adminFetchPosts(page = 1) {
  const res = await fetch(`${API}/blog/posts?page=${page}`, { headers: authHeaders() })
  if (!res.ok) throw new Error('Failed to load posts')
  return res.json()
}

export async function fetchPosts(page = 1) {
  const res = await fetch(`${API}/posts?page=${page}`)
  if (!res.ok) throw new Error('Failed to load posts')
  return res.json()
}

export async function fetchPost(id) {
  const res = await fetch(`${API}/posts/${id}`)
  if (!res.ok) throw new Error('Failed to load post')
  return res.json()
}
