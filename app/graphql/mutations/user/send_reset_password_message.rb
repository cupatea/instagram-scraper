class Mutations::User::SendResetPasswordMessage < ApplicationMutation
  description "Sends message via Instagram to reset password"

  argument :email, String, required: true

  field :errors, [String],           null: false
  field :success, Boolean,           null: false

  def resolve(email:)
    outcome = ::User::SendResetPasswordMessage.run(email: email)

    if outcome.success?
      success_mutation
    else
      failed_mutation(outcome.errors.message_list)
    end
  end
end
