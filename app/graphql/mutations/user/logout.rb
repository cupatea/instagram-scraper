class Mutations::User::Logout < GraphQL::Schema::Mutation
  description "Logs out current user: delete used token from user's tokens"

  field :user,         Types::User, null: true
  field :errors,       [String],          null: false
  field :access_token, String,            null: true
  field :success,      Boolean,           null: false

  def resolve
    if context[:current_user]&.remove_access_token(client_id: context[:client_id])
      { success: true,
        errors: [],
        access_token: context[:access_token] }
    else
      { success: false,
        errors: ['Provided access token or client id is not valid'],
        access_token: context[:access_token] }
    end
  end
end
