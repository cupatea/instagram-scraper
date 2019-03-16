class InstagramUser < ApplicationRecord
  has_many :followers_data, dependent: :destroy
  validates :username, presence: true, uniqueness: true

  def create_followers_datum_now logger: 'rails'
    outcome = Instagram::Scrape.run(username: username, logger: logger)
    if outcome.success?
      followers_data.create(scrape_time: Time.zone.now, count: outcome.result.user[:followers_count])
    else
      false
    end
  end
end
