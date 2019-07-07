import React, {useState} from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import {navigate} from '@reach/router'

import {SignUpForm} from '../components'
import {AnonymousContainer, routes} from '../components'
import {setTokens} from '../utils'
import {SignUpUserMutation} from '../graphql'

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
          mutation={SignUpUserMutation}
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
