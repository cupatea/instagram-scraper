class Types::UserObject < Types::Base::Object
  description 'User object'

  field :email,     String,  null: false
  field :uid,       String,  null: false
  field :confirmed, Boolean, null: false, method: :confirmed?
end
