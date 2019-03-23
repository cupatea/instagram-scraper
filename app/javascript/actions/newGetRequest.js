export default async function newGetRequest(url) {
  const init = { credentials: 'same-origin' }
  return fetch(new Request(url, init))
    .then(response => response.json())
}
