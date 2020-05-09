class Mutations::User::SignUp < ApplicationMutation
  description 'Creates a user'

  argument :password, String, required: true
  argument :username, String, required: true

  field :user,   Types::User,  null: true
  field :token,  Types::Token, null: true
  field :errors, [String],     null: false
  field :success, Boolean,     null: false

  def resolve(password:, username:)
    user = User.new(username: username, uid: username, password: password)
    user.instagram_users << InstagramUser.find_or_initialize_by(username: username)

    if user.save
      success_mutation(user: user, token: user.create_new_auth_token)
    else
      failed_mutation(user.errors.to_a, user: nil, token: nil)
    end
  end
end
