import React, {useState} from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import {navigate} from '@reach/router'
import gql from 'graphql-tag'

import { SignUpForm } from '../components'
import { AnonymousContainer, routes} from '../components'
import {setTokens} from '../utils'

export const SIGN_UP_USER = gql`
  mutation($email: String!, $password: String!, $username: String!) {
    signUpUser(email: $email, password: $password, username: $username) {
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

export default function SignUp() {
  const [errors, setErrors] = useState([])
  const setTokenToStorage = (client, { success, token, errors }) => {
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
          mutation={SIGN_UP_USER}
          onCompleted={({signUpUser}) => setTokenToStorage(client, signUpUser)}>
        {
          (signUpFunction, {error}) => {
            return(
              <AnonymousContainer messages={errors}>
                <SignUpForm
                  signUpFunction={signUpFunction}
                  loginPagePath={routes.loginPagePath}
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
