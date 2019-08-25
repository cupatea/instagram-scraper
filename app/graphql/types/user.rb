class Types::User < Types::Base::Object
  description 'User object'

  field :username,  String,  null: false
  field :uid,       String,  null: false
  field :confirmed, Boolean, null: false, method: :confirmed?
end
