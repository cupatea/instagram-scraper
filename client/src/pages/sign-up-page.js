import React, {useState} from 'react'
import { useMutation } from '@apollo/react-hooks';
import {navigate} from '@reach/router'

import {SignUpForm, AnonymousContainer, routes, client} from '../components'
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

  const [signUpFunction, {loading}] = useMutation(
    SignUpUserMutation,
    { onCompleted: ({signUpUser}) => setTokenToStorage(client, signUpUser) }
  )

  return(
    <AnonymousContainer messages={errors}>
      <SignUpForm
        signUpFunction={signUpFunction}
        loginPagePath={routes.loginPagePath}
        loading = {loading}
      />
    </AnonymousContainer>
  )
}
