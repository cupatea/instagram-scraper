import React, {useState} from 'react'
import {navigate} from '@reach/router'
import { useMutation } from '@apollo/react-hooks';

import {ResetPasswordForm, AnonymousContainer, routes, client} from '../components'
import {setTokens} from '../utils'
import {SendResetPasswordMessage, ResetPassword} from '../graphql'

export default function Login() {
  const [errors, setErrors] = useState([])
  const [resetPasswordMessageSent, setResetPasswordMessageSent] = useState(false)

  function setTokenToStorage(token) {
    setTokens(token)
    navigate(routes.dashboardPagePath)
  }

  function setErrorsFromMutation(errors) {
    setErrors(errors.map(error => ({id: client.queryManager.idCounter, content: error})))
  }

  const [
    resetPasswordFunction,
    {loading: resetPasswordLoading}
  ] = useMutation(
    ResetPassword,
    {
       onCompleted: ({resetPassword}) =>
        resetPassword.success
          ? setTokenToStorage(resetPassword.token)
          : setErrorsFromMutation(resetPassword.errors)
    }
  )

  const [
    sendResetPasswordMessageFunction,
    {loading: sendResetPasswordMessageLoading}
  ] = useMutation(
    SendResetPasswordMessage,
    {
      onCompleted: ({sendResetPasswordMessage}) =>
      sendResetPasswordMessage.success
        ? setResetPasswordMessageSent(true)
        : setErrorsFromMutation(sendResetPasswordMessage.errors)
     }
  )

  return(
    <AnonymousContainer messages={errors}>
      <ResetPasswordForm
        sendResetPasswordMessageLoading={sendResetPasswordMessageLoading}
        resetPasswordLoading={resetPasswordLoading}
        resetPasswordFunction={resetPasswordFunction}
        resetPasswordMessageSent={resetPasswordMessageSent}
        sendResetPasswordMessageFunction={sendResetPasswordMessageFunction}
        loginPagePath={routes.loginPagePath}
        signUpPagePath={routes.signUpPagePath}
      />
    </AnonymousContainer>
  )
}
