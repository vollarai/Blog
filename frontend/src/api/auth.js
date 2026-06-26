import { ref } from 'vue'

const API = '/api'

export const isLoggedIn = ref(!!localStorage.getItem('token'))
export const currentUser = ref(JSON.parse(localStorage.getItem('user') || 'null'))

function setAuth(data) {
    localStorage.setItem('token', data.token)
    localStorage.setItem('user', JSON.stringify(data.user))
    isLoggedIn.value = true
    currentUser.value = data.user
}

export function clearAuth() {
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    isLoggedIn.value = false
    currentUser.value = null
}

function authHeaders() {
    const token = localStorage.getItem('token')
    return token ? { 'Authorization': `Bearer ${token}` } : {}
}

async function throwIfError(res, fallback) {
    if (res.ok) return
    const body = await res.json().catch(() => null)
    const message = body?.errors?.join(', ') || body?.error || fallback
    throw new Error(message)
}

export async function login(email, password) {
    const res = await fetch(`${API}/session`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email_address: email, password })
    })
    await throwIfError(res, 'Invalid email or password')
    const data = await res.json()
    setAuth(data)
    return data
}

export async function signup(firstName, lastName, email, password, passwordConfirmation) {
    const res = await fetch(`${API}/sign_up`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user: { first_name: firstName, last_name: lastName, email_address: email, password, password_confirmation: passwordConfirmation } })
    })
    await throwIfError(res, 'Sign up failed')
    const data = await res.json()
    setAuth(data)
    return data
}

export async function updatePassword(currentPassword, newPassword, passwordConfirmation) {
    const res = await fetch(`${API}/settings/password`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify({ user: { password_challenge: currentPassword, password: newPassword, password_confirmation: passwordConfirmation } })
    })
    await throwIfError(res, 'Failed to update password')
    return res.json()
}

export async function deleteAccount() {
    const res = await fetch(`${API}/settings/user`, {
        method: 'DELETE',
        headers: { ...authHeaders() }
    })
    await throwIfError(res, 'Failed to delete account')
    return res.json()
}

export async function updateEmail(newEmail, currentPassword) {
    const res = await fetch(`${API}/settings/email`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify({ user: { unconfirmed_email: newEmail, password_challenge: currentPassword } })
    })
    await throwIfError(res, 'Failed to update email')
    return res.json()
}

export async function updateProfile(firstName, lastName) {
    const res = await fetch(`${API}/settings/profile`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json', ...authHeaders() },
        body: JSON.stringify({ user: { first_name: firstName, last_name: lastName } })
    })
    await throwIfError(res, 'Failed to update profile')
    return res.json()
}
