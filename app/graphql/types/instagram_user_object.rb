class Types::InstagramUserObject < Types::Base::Object
  description 'Instagram user object'

  field :id,          Integer, null: false
  field :username,    String,  null: false
  field :posts_count, Integer, null: false
end
