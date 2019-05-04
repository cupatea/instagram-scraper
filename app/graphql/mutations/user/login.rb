class Mutations::User::Login < GraphQL::Schema::Mutation
  description 'Logs in a user with credentials'

  argument :email,    String, required: true
  argument :password, String, required: true

  field :token,  String,               null: true
  field :user,   Types::User::Object,  null: true
  field :errors, [String],             null: false

  def resolve(email:, password:)
    user = User.find_for_authentication(email: email)

    if (user&.valid_for_authentication?) && user.valid_password?(password)
      { token: user.generate_token,
        user: user,
        errors: [] }
    else
      { token: nil,
        user: nil,
        errors: ['Invalid credentials'] }
    end
  end
end
