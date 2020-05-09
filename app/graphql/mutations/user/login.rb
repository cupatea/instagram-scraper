class Mutations::User::Login < ApplicationMutation
  description 'Logs in a user with credentials'

  argument :username, String, required: true
  argument :password, String, required: true

  field :user,   Types::User,  null: true
  field :token,  Types::Token, null: true
  field :errors, [String],     null: false
  field :success, Boolean,     null: false

  def resolve(username:, password:)
    user = User.find_for_authentication(username: username)

    if user&.valid_for_authentication? && user&.valid_password?(password)
      success_mutation(token: user.create_new_auth_token, user: user)
    else
      failed_mutation(['Invalid credentials'], token: nil, user: nil)
    end
  end
end
