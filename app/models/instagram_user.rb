class InstagramUser < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :followers_data, dependent: :destroy
  has_many :observations, as: :observee, dependent: :destroy
  has_many :users, as: :observer, through: :observations, source: :observer, source_type: 'User'
  has_many :admins, as: :observer, through: :observations, source: :observer, source_type: 'Admin'
  enum status: { pending: 0, exist: 1, nonexistent: 2 }

  delegate :instagram_id,
           :full_name,
           :followers_count,
           :following_count,
           :biography,
           :externale_url,
           :is_private,
           :is_verified,
           :profile_pic_url,
           :profile_pic_url_hd, to: :data_struct

  def data_struct
    OpenStruct.new(data || {})
  end

  def create_followers_datum_now logger: 'rails'
    outcome = Instagram::Scrape.run(username: username, logger: logger)
    if outcome.success?
      exist!
      update(data: outcome.result.user)
      followers_data.create(scrape_time: Time.zone.now,
                            new_post: new_post?(actual_posts_count: outcome.result.posts[:count]),
                            count: outcome.result.user[:followers_count])

    else
      nonexistent!
    end
  end

  def new_post? actual_posts_count:
    if actual_posts_count.present? && actual_posts_count > posts_count
      update(posts_count: actual_posts_count)
      true
    else
      false
    end
  end
end
