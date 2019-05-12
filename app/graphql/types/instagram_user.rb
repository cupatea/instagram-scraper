class Types::InstagramUser < Types::Base::Object
  description 'Instagram user object'

  field :id,             Integer,                 null: false
  field :username,       String,                  null: false
  field :posts_count,    Integer,                 null: false
  field :followers_data, [Types::FollowersDatum], null: false
end
