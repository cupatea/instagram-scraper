class Mutations::User::Login < GraphQL::Schema::Mutation
  description 'Logs in a user with credentials'

  argument :email,    String, required: true
  argument :password, String, required: true

  field :user,   Types::User,  null: true
  field :token,  Types::Token, null: true
  field :errors, [String],           null: false
  field :success, Boolean,           null: false

  def resolve(email:, password:)
    user = User.find_for_authentication(email: email)

    if (user&.valid_for_authentication?) && user.valid_password?(password)
      { success: true,
        errors: [],
        token: user.create_new_auth_token,
        user: user }
    else
      { success: false,
        errors: ['Invalid credentials'],
        token: nil,
        user: nil }
    end
  end
end
