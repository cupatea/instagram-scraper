import React, {useState} from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import gql from 'graphql-tag'

import { SignUpForm } from '../components'
import { AnonymousContainer } from '../components'

export const SIGN_UP_USER = gql`
  mutation($email: String!, $password: String!) {
    signUpUser(email: $email, password: $password) {
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
          mutation={SIGN_UP_USER}
          onCompleted={({signUpUser}) => setTokenToStorage(client, signUpUser)}>
        {
          (signUpFunction, {error}) => {
            if (error) setErrors([error])

            return(
              <AnonymousContainer messages={errors}>
                <SignUpForm signUpFunction={signUpFunction} />
              </AnonymousContainer>
            )
          }
        }
        </Mutation>
    }
    </ApolloConsumer>
  )
}
