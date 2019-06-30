import { loader } from 'graphql.macro'

export const LoginUserMutation = loader('./mutations/login-user.graphql')
export const LogoutUserMutation = loader('./mutations/logout-user.graphql')
export const SignUpUserMutation = loader('./mutations/sign-up-user.graphql')
