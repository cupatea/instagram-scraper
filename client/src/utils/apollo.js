import {ApolloClient} from 'apollo-client'
import {InMemoryCache} from 'apollo-cache-inmemory'
import {HttpLink} from 'apollo-link-http'
import {onError} from 'apollo-link-error'
import {ApolloLink, Observable} from 'apollo-link'

export function createCache() {
  const cache = new InMemoryCache()
  if (process.env.NODE_ENV === 'development') {
    window.secretVariableToStoreCache = cache
  }
  return cache
}

export function isTokens() {
  return !!getTokens()
}

export function setTokens({accessToken, client, uid}) {
  localStorage.setItem('authTokens', JSON.stringify({
    'token-type': 'Bearer',
    'access-token': accessToken,
    client,
    uid,
  }))
}

export function clearTokens(){
  localStorage.removeItem('authTokens')
}

function getTokens() {
  return JSON.parse(localStorage.getItem('authTokens'))
}

async function setTokenForOperation(operation) {
  return operation.setContext({
    headers: {
      'Content-Type': 'application/json',
      ...getTokens(),
    },
  })
}

// link with token
function createLinkWithToken() {
  return(
    new ApolloLink((operation, forward) =>
      new Observable(observer => {
        let handle
        Promise.resolve(operation)
          .then(setTokenForOperation)
          .then(() => {
            handle = forward(operation).subscribe({
              next: observer.next.bind(observer),
              error: observer.error.bind(observer),
              complete: observer.complete.bind(observer),
            })
          })
          .catch(observer.error.bind(observer))
        return () => {
          if (handle) handle.unsubscribe()
        }
      })
    )
  )
}

// log erors
function logError(error) {
  console.error(error)
}

// create error link
function createErrorLink() {
  return(
    onError(({ graphQLErrors, networkError, operation }) => {
      if (graphQLErrors) {
        logError('GraphQL - Error', {
          errors: graphQLErrors,
          operationName: operation.operationName,
          variables: operation.variables,
        })
      }
      if (networkError) {
        logError('GraphQL - NetworkError', networkError)
      }
    })
  )
}

function createHttpLink() {
  return new HttpLink({
    uri: process.env.REACT_APP_API_URI || 'http://localhost:5000/graphql'
  })
}

export function createClient(cache, requestLink) {
  return new ApolloClient({
    link: ApolloLink.from([
      createErrorLink(),
      createLinkWithToken(),
      createHttpLink(),
    ]),
    cache,
  })
}
