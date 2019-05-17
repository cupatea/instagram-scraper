import React, {useState} from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import gql from 'graphql-tag'

import { LoginForm } from '../components'
import { PageContainer } from '../components'

export const LOGIN_USER = gql`
  mutation($email: String!, $password: String!) {
    loginUser(email: $email, password: $password) {
      success
      errors
      token {
        accessToken
        client
        expiry
        tokenType
        uid
      }
    }
  }
`

export default function Login() {
  const [errors, setErrors] = useState([])
  const setTokenToStorage = (client, { success, token, errors }) => {
    if (success) {
      localStorage.setItem('token', token.accessToken)
      localStorage.setItem('client', token.client)
      localStorage.setItem('uid', token.uid)
      client.writeData({data: {isLoggedIn: true} })
    } else {
      // add an id to the error so to be awere that error comes from new request
      setErrors(errors.map(error => ({id: client.queryManager.idCounter, content: error})))
    }
  }

  return(
    <ApolloConsumer>
    {
      client =>
        <Mutation
          mutation={LOGIN_USER}
          onCompleted={({loginUser}) => setTokenToStorage(client, loginUser)}>
        {
          (loginFunction, {error}) => {
            if (error) setErrors([error])

            return(
              <PageContainer messages={errors}>
                <LoginForm loginFunction={loginFunction} />
              </PageContainer>
            )
          }
        }
        </Mutation>
    }
    </ApolloConsumer>
  )
}
