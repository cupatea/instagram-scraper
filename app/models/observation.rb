class Observation < ApplicationRecord
  belongs_to :observer, polymorphic: true
  belongs_to :observee, polymorphic: true

  validates :observee_id, uniqueness: { scope: [:observer_id, :observer_type, :observee_type] }
  before_destroy :ensure_one

  def ensure_one
    unless observer.is_a?(User) && observee.is_a?(InstagramUser) && observer.instagram_users.many?
      errors.add :base, 'User should have at least one observation'
      throw :abort
    end
  end
end
