export function getTokens() {
  return JSON.parse(localStorage.getItem('authTokens'))
}

export function setTokens({accessToken, client, uid, expiry}) {
  localStorage.setItem('authTokens', JSON.stringify({
    'token-type': 'Bearer',
    'access-token': accessToken,
    client,
    uid,
    expiry
  }))
}

export function isTokens() {
  const currentToken = getTokens()
  const currentSeconds = Math.floor(Date.now() / 1000)

  if(currentToken && currentToken.expiry > currentSeconds) {
    return true
  } else {
    clearTokens()
    return false
  }
}
export function clearTokens(){
  localStorage.removeItem('authTokens')
}
