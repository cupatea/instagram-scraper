import React from "react"
import { ApolloProvider } from "react-apollo"
import { createCache, createClient } from "../utils"

export default function Provider({ children }) {
  return(
    <ApolloProvider client={createClient(createCache())}>
      {children}
    </ApolloProvider>
  )
}
