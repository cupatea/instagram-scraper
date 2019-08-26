class Mutations::User::ResetPassword < GraphQL::Schema::Mutation
  description 'Resets password and logs in a user'

  argument :username,            String, required: true
  argument :new_password,        String, required: true
  argument :reset_password_code, String, required: true

  field :user,   Types::User,  null: true
  field :token,  Types::Token, null: true
  field :errors, [String],           null: false
  field :success, Boolean,           null: false

  def resolve(username:, new_password:, reset_password_code:)
    outcome = ::User::ResetPassword.run(
      username: username,
      new_password: new_password,
      reset_password_code: reset_password_code
    )

    if outcome.success?
      { success: true,
        errors: [],
        token: outcome.result.token,
        user: outcome.result.user }
    else
      { success: false,
        errors: outcome.errors.message_list,
        token: nil,
        user: nil }
    end
  end
end
