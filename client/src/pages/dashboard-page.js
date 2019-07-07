import React, { Fragment, useState, useEffect } from 'react'
import {Mutation, ApolloConsumer} from 'react-apollo'
import {navigate} from '@reach/router'

import { UserContainer, Dashboard, routes } from '../components'
import {clearTokens, isTokens} from '../utils'
import {LogoutUserMutation} from '../graphql'


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
          mutation={LogoutUserMutation}
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
