class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :observations, as: :observer, dependent: :destroy
  has_many :instagram_users, as: :observee, through: :observations, source: :observee, source_type: 'InstagramUser'

  enum role: [:root, :standard]
end
