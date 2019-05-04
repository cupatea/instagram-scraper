module EnsureUuid
  extend ActiveSupport::Concern

  included do
    before_validation :set_uuid
    validates :uuid, presence: true
  end

  def set_uuid
    self.uuid = UUID.new.generate if uuid.blank?
  end
end
