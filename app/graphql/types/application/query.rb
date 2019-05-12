class Types::Application::Query < Types::Base::Object
  field :viewer, Types::UserObject, null: true
  def viewer
    context[:current_user]
  end
end
