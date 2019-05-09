class Observation < ApplicationRecord
  belongs_to :observer, polymorphic: true
  belongs_to :observee, polymorphic: true
end
