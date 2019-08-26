import React from 'react'
import {Router as ReachRouter, Redirect} from '@reach/router'
import {useSpring, animated} from 'react-spring'

import {DashboardPage, LoginPage, SignUpPage, ResetPasswordPage} from '../pages'
import {isTokens as isLoggedIn} from '../utils'

export const routes = {
  rootPath:              '/',
  dashboardPagePath:     '/dashboard',
  loginPagePath:         '/login',
  signUpPagePath:        '/sign-up',
  resetPasswordPagePath: '/reset-password',
}

export default function Router(){
  const transition = useSpring({opacity: 1, from:{opacity: 0}})

  const resolveRedirectPath =
    isLoggedIn()
      ? routes.dashboardPagePath
      : routes.loginPagePath

  return(
    <animated.div style={transition} >
      <ReachRouter primary={true}>
        <Redirect
         from={routes.rootPath}
         to={resolveRedirectPath}
         noThrow
       />

        <LoginPage path={routes.loginPagePath}/>
        <SignUpPage path={routes.signUpPagePath}/>
        <ResetPasswordPage path={routes.resetPasswordPagePath} />
        <DashboardPage path={routes.dashboardPagePath} />
      </ReachRouter>
    </animated.div>
  )
}
