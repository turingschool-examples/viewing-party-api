class ViewingParty < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  validates :host_id, presence: true
  validate :end_time_before_start_time
  belongs_to :host, class_name: 'User'
  has_many :users_viewing_parties
  has_many :users, through: :users_viewing_parties

  def add_user_invitees(invitees)
    users.concat(invitees)
  end

  def end_time_before_start_time
    if end_time && start_time && end_time <= start_time
      errors.add(:end_time, "must come after start time")
    end
  end
end