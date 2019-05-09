class Observation < ApplicationRecord
  belongs_to :observer, polymorphic: true
  belongs_to :observee, polymorphic: true

  validates :observee_id, uniqueness: { scope: [:observer_id, :observer_type, :observee_type] }
end
