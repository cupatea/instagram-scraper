class Mutations::User::Logout < GraphQL::Schema::Mutation
  description "Logs out current user: delete used token from user's tokens"

  field :user,         Types::UserObject, null: true
  field :errors,       [String],          null: false
  field :access_token, String,            null: true

  def resolve
    user         = context[:current_user]
    access_token = context[:access_token]
    client_id    = context[:client_id]
    if user && client_id.nil?
      { access_token: access_token,
        errors: ['Client id is not provided'] }
    elsif user&.remove_access_token(client_id: client_id)
      { access_token: access_token,
        errors: [] }
    else
      { access_token: access_token,
        errors: ['Provided access token is not valid'] }
    end
  end
end
