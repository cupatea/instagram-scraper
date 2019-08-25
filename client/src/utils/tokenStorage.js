export function getTokens() {
  return JSON.parse(localStorage.getItem('authTokens'))
}

export function setTokens({accessToken, client, uid}) {
  localStorage.setItem('authTokens', JSON.stringify({
    'token-type': 'Bearer',
    'access-token': accessToken,
    client,
    uid,
  }))
}

export function isTokens() {
  return !!getTokens()
}
export function clearTokens(){
  localStorage.removeItem('authTokens')
}
