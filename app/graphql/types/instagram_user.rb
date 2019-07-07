class Types::InstagramUser < Types::Base::Object
  description 'Instagram user object'

  field :id,             Integer,                 null: false
  field :username,       String,                  null: false
  field :posts_count,    Integer,                 null: false
  field :followers_data, [Types::FollowersDatum], null: false do
    argument :scrape_time_form, String, required: false, default_value: nil
    argument :scrape_time_to,   String, required: false, default_value: nil
  end

  def followers_data(arguments_hash)
    object.followers_data.scope_filter(arguments_hash)
  end
end
