import React, { Fragment, useState, useEffect } from 'react'
import { useMutation, useQuery } from '@apollo/react-hooks';
import {navigate} from '@reach/router'
import ta from 'time-ago'

import { FollowersChart, UserContainer, Dashboard, routes, client } from '../components'
import {clearTokens, isTokens} from '../utils'
import {LogoutUserMutation, ObservationsQuery} from '../graphql'

export default function DashboardPage() {
  useEffect(() => {
    if(!isTokens()) navigate(routes.loginPagePath)
  })

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

  function prepareData(data) {
    return data.map(datum => (
      {
        time: ta.ago(datum.scrapeTime * 1000),
        followers: datum.count,
        posts: datum.newPost ? datum.count : 0,
      }
    ))
  }

  const [logoutFunction, {loading}] = useMutation(
    LogoutUserMutation,
    { onCompleted: ({logoutUser}) => removeTokenFromStorage(client, logoutUser) }
  )

  const {
    loading: obsorvationsLoading,
    data: obsorvationsData,
    error: obsorvationsError,
  } = useQuery(ObservationsQuery)

  const renderObsorvationsList = () => {
    if(obsorvationsLoading) return 'loading'
    if(obsorvationsError) return `Error! ${obsorvationsError.message}`
    return obsorvationsData.observations.map(observation =>(
        <FollowersChart
          key={observation.id}
          followersData={prepareData(observation.observee.followersData)}
          username={observation.observee.username}
          profilePicUrl={observation.observee.profilePicUrl}
          postsCount={observation.observee.postsCount}
          followersCount={observation.observee.followersCount}
        />
    ))
  }

  return(
    <Fragment>
      <UserContainer messages={errors}>
        <Dashboard
          loading={loading}
          logoutFunction={logoutFunction}
          path={routes.loginPagePath}
        >
        { renderObsorvationsList() }
        </Dashboard>
      </UserContainer>
    </Fragment>
  )
}
