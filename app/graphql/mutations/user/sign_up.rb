class Mutations::User::SignUp < GraphQL::Schema::Mutation
  description 'Creates a user'

  argument :email,    String, required: true
  argument :password, String, required: true
  argument :username, String, required: true

  field :user,   Types::User,  null: true
  field :token,  Types::Token, null: true
  field :errors, [String],           null: false
  field :success, Boolean,           null: false

  def resolve(email:, password:, username:)
    user = User.new(email: email, password: password)
    user.instagram_users << InstagramUser.find_or_initialize_by(username: username)

    if user.save
      { success: true,
        errors: [],
        token: user.create_new_auth_token,
        user: user }
    else
      { success: false,
        errors: user.errors.to_a,
        token: nil,
        user: nil }
    end
  end
end
