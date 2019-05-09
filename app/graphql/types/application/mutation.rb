class Types::Application::Mutation < Types::Base::Object

  # USERS
  field :login_user,    mutation: Mutations::User::Login
  field :logout_user,   mutation: Mutations::User::Logout
  field :sign_up_user,  mutation: Mutations::User::SignUp
end
