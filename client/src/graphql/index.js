import { loader } from 'graphql.macro'

export const LoginUserMutation = loader('./mutations/login-user.graphql')
export const LogoutUserMutation = loader('./mutations/logout-user.graphql')
export const SignUpUserMutation = loader('./mutations/sign-up-user.graphql')
export const SendResetPasswordMessage = loader('./mutations/send-reset-password-message.graphql')
export const ResetPassword = loader('./mutations/reset-password.graphql')

export const ObservationsQuery = loader('./queries/observations.graphql')
