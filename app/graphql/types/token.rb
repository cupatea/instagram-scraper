class Types::Token < Types::Base::Object
  description 'Token object'

  field :access_token, String, null: false, hash_key: :'access-token'
  field :token_type,   String, null: false, hash_key: :'token-type'
  field :client,       String, null: false
  field :expiry,       String, null: false
  field :uid,          String, null: false
end
