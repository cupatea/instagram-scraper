import React, {useState} from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import gql from 'graphql-tag'

import { LoginForm } from '../components'

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
      setErrors(errors)
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
          (login, {error}) => {
            if (error) setErrors([error])

            return(
              <LoginForm
                login={login}
                errors={errors} />
            )
          }
        }
        </Mutation>
    }
    </ApolloConsumer>
  )
}
