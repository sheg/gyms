class User < ActiveRecord::Base

  validates :email, uniqueness: true,
                    presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_many :appointments
  has_many :events, through: :appointments



end
