class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: { require: true }
  has_secure_password
  has_secure_token :api_key
  has_many :users_viewing_parties
  has_many :viewing_parties, through: :users_viewing_parties

  def self.find_user_id(invitees)
    where(id: invitees)
  end
end