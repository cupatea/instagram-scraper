class Types::FollowersDatum < Types::Base::Object
  description "InstagramUser's followers count in particular time"

  field :id,          Integer, null: false
  field :count,       Integer, null: false
  field :scrape_time, Integer, null: false
  field :new_post,    Boolean, null: false
end
