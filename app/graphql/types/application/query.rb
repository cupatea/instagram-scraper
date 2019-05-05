class Types::Application::Query < Types::Base::Object
  field :me, Types::UserObject, null: true
  def me
    context[:current_user]
  end
end
