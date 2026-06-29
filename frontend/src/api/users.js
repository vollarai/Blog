const API = '/api'

function authHeaders() {
  const token = localStorage.getItem('token')
  return token ? { 'Authorization': `Bearer ${token}` } : {}
}

export async function adminFetchUsers(page = 1) {
    const res = await fetch(`${API}/blog/users?page=${page}`, { headers: authHeaders() })
    if (!res.ok) throw new Error('Failed to load posts')
    return res.json()
}