class Mutations::User::SendResetPasswordMessage < GraphQL::Schema::Mutation
  description "Sends message via Instagram to reset password"

  argument :username, String, required: true

  field :errors, [String],           null: false
  field :success, Boolean,           null: false

  def resolve(username:)
    outcome = ::User::SendResetPasswordMessage.run(username: username)

    if outcome.success?
      { success: true,
        errors: [] }
    else
      { success: false,
        errors: outcome.errors.message_list }
    end
  end
end
