class Mutations::User::Logout < ApplicationMutation
  description "Logs out current user: delete used token from user's tokens"

  field :user,         Types::User,       null: true
  field :errors,       [String],          null: false
  field :access_token, String,            null: true
  field :success,      Boolean,           null: false

  def resolve
    if context[:current_user]&.remove_access_token(client_id: context[:client_id])
      success_mutation(access_token: context[:access_token])
    else
      failed_mutation(['Provided access token or client id is not valid'],
                      access_token: context[:access_token])
    end
  end
end
