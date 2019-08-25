import React, {useState} from 'react'
import {navigate} from '@reach/router'
import { useMutation } from '@apollo/react-hooks';

import {LoginForm, AnonymousContainer, routes, client} from '../components'
import {setTokens} from '../utils'
import {LoginUserMutation} from '../graphql'

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

  const [loginFunction, {loading}] = useMutation(
    LoginUserMutation,
    { onCompleted: ({loginUser}) => setTokenToStorage(client, loginUser) }
  )

  return(
    <AnonymousContainer messages={errors}>
      <LoginForm
        loading={loading}
        loginFunction={loginFunction}
        signUpPagePath={routes.signUpPagePath}
      />
    </AnonymousContainer>
  )
}
