class Mutations::User::Logout < GraphQL::Schema::Mutation
  description "Logs out current user: delete used token from user's tokens"

  field :user,         Types::UserObject, null: true
  field :errors,       [String],          null: false
  field :access_token, String,            null: true

  def resolve
    if context[:current_user]&.remove_access_token(client_id: context[:client_id])
      { access_token: context[:access_token],
        errors: [] }
    else
      { access_token: context[:access_token],
        errors: ['Provided access token or client id is not valid'] }
    end
  end
end
