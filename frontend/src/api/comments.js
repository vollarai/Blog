const API = '/api'

function authHeaders() {
  const token = localStorage.getItem('token')
  return token ? { 'Authorization': `Bearer ${token}` } : {}
}

export async function fetchComments(postId) {
  const res = await fetch(`${API}/posts/${postId}/comments`)
  if (!res.ok) throw new Error('Failed to load comments')
  return res.json()
}

export async function createComment(postId, body) {
  const res = await fetch(`${API}/posts/${postId}/comments`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', ...authHeaders() },
    body: JSON.stringify({ comment: { body } })
  })
  if (!res.ok) throw new Error('Failed to post comment')
  return res.json()
}
