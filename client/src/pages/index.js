import React, { Fragment } from 'react'
import { Router } from '@reach/router'
import { UserContainer, Dashboard } from '../components'

export default function Pages() {
  return (
    <Fragment>
      <UserContainer>
        <Router primary={false} component={Fragment}>
          <Dashboard path="/" />
        </Router>
      </UserContainer>
    </Fragment>
  )
}
