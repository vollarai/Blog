const API = '/api'

export async function login(email, password) {
    const res = await fetch(`${API}/session`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email_address: email, password})
    })
    if (!res.ok) throw new Error('Invalid email or password')
    return res.json()
}

export async function signup(firstName, lastName, email, password) {
    const res = await fetch(`${API}/sign_up`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ first_name: firstName, last_name: lastName, email_address: email, password })
    })
    if (!res.ok) throw new Error('Sign up failed')
    return res.json()
}

export async function updateProfile(firstName, lastName) {
    const token = localStorage.getItem('token')
    const res = await fetch(`${API}/settings/profile`, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({ user: { first_name: firstName, last_name: lastName } })
    })
    if (!res.ok) throw new Error('Failed to update profile')
    return res.json()
}