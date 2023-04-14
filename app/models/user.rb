class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :events
  has_many :invitations
  has_many :attended_events, through: :invitations, source: :event

  def fullname
    "#{first_name} #{last_name}"
  end
end
