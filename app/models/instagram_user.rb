class InstagramUser < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :followers_data, dependent: :destroy
  belongs_to :user

  def create_followers_datum_now logger: 'rails'
    outcome = Instagram::Scrape.run(username: username, logger: logger)
    if outcome.success?
      followers_data.create(scrape_time: Time.zone.now,
                            new_post: new_post?(actual_posts_count: outcome.result.posts[:count]),
                            count: outcome.result.user[:followers_count])

    else
      false
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
