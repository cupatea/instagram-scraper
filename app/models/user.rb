class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, authentication_keys: [:username]

  has_many :observations, as: :observer, dependent: :destroy
  has_many :instagram_users, as: :observee, through: :observations, source: :observee, source_type: 'InstagramUser'

  validates :username, uniqueness: true
  validates_associated :instagram_users, message: 'username does not exit on Instagram', unless: :persisted?

  def confirm_now!
    update confirmed_at: Time.zone.now
  end

  def reset_confirmation_token!
    update(confirmation_token: Devise.friendly_token)
  end

  def remove_access_token client_id:
    tokens[client_id].present? && update(tokens: tokens.except(client_id))
  end

  def own_instagram_user
    instagram_users.find_by(username: username)
  end
end
