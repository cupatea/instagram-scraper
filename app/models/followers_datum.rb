class FollowersDatum < ApplicationRecord
  include Filterable
  belongs_to :instagram_user
  validates :count, presence: true

  scope :filter_scrape_time_form, ->(form) { where(arel_table[:scrape_time].gt(form)) }
  scope :filter_scrape_time_to,   ->(to) { where(arel_table[:scrape_time].lt(to)) }
end
