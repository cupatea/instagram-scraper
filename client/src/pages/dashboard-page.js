import React, { Fragment, useState, useEffect } from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import {navigate} from '@reach/router'
import gql from 'graphql-tag'

import { UserContainer, Dashboard, routes } from '../components'
import {clearTokens, isTokens} from '../utils'

export const LOGOUT_USER = gql`
  mutation {
    logoutUser {
      success
      errors
    }
  }
`

export default function DashboardPage() {
  const [errors, setErrors] = useState([])
  function removeTokenFromStorage(client, { success, errors }) {
    if (success) {
      clearTokens()
      navigate(routes.loginPagePath)
    } else {
      // add an id to the error so to be awere that error comes from new request
      setErrors(errors.map(error => ({id: client.queryManager.idCounter, content: error})))
    }
  }

  useEffect(() => {
    if(!isTokens()) navigate(routes.loginPagePath)
  })

  return(
    <ApolloConsumer>
    {
      client =>
        <Mutation
          mutation={LOGOUT_USER}
          onCompleted={({logoutUser}) => removeTokenFromStorage(client, logoutUser)}>
        {
          (logoutFunction) => {
            return(
              <Fragment>
                <UserContainer messages={errors}>
                  <Dashboard logoutFunction={logoutFunction} path={routes.loginPagePath} />
                </UserContainer>
              </Fragment>
            )
          }
        }
        </Mutation>
    }
    </ApolloConsumer>
  )
}
