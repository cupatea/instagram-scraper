class User < ApplicationRecord
  include UserConst
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable, :trackable

  has_many :instagram_users, dependent: :destroy

  def confirm_now!
    update confirmed_at: Time.zone.now
  end

  def reset_confirmation_token!
    update(confirmation_token: Devise.friendly_token)
  end
end
