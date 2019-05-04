class Types::User::Object < Types::Base::Object
  description 'User object'

  field :email, String, null: false
  field :uuid,  String, null: false
end
