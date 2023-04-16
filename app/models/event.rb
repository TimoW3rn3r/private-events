class Event < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :user

  scope :past, -> { where('date < ?', Time.now) }
  scope :upcoming, -> { where('date >= ?', Time.now) }

  validates :date, :time, presence: true
end
