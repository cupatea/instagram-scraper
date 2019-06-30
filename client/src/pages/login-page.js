import React, {useState} from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import {navigate} from '@reach/router'
import gql from 'graphql-tag'

import {LoginForm} from '../components'
import {AnonymousContainer, routes} from '../components'
import {setTokens} from '../utils'

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

  function setTokenToStorage(client, { success, token, errors }) {
    if (success) {
      setTokens(token)
      navigate(routes.dashboardPagePath)
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
            return(
              <AnonymousContainer messages={errors}>
                <LoginForm
                  loginFunction={loginFunction}
                  signUpPagePath={routes.signUpPagePath}
                />
              </AnonymousContainer>
            )
          }
        }
        </Mutation>
    }
    </ApolloConsumer>
  )
}
