class Types::Application::Mutation < Types::Base::Object
  # USERS
  field :login_user,                  mutation: Mutations::User::Login
  field :logout_user,                 mutation: Mutations::User::Logout
  field :sign_up_user,                mutation: Mutations::User::SignUp
  field :send_reset_password_message, mutation: Mutations::User::SendResetPasswordMessage
  field :reset_password,              mutation: Mutations::User::ResetPassword

  # OBSERVATIONS
  field :create_observation, mutation: Mutations::Observation::Create, authorize!: true
  field :delete_observation, mutation: Mutations::Observation::Delete, authorize!: true
  field :update_observation, mutation: Mutations::Observation::Update, authorize!: true
end
