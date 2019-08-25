import React from "react"
import { ApolloProvider } from '@apollo/react-hooks';
import ApolloClient from 'apollo-boost'
import { getTokens } from '../utils'

export const client = new ApolloClient({
  uri: process.env.REACT_APP_API_URI,
  request: (operation) => {
    operation.setContext({
      headers: {
        'Content-Type': 'application/json',
        ...getTokens(),
      },
    })
  }
})

export default function Provider({ children }) {
  return(
    <ApolloProvider client={client}>
      {children}
    </ApolloProvider>
  )
}
