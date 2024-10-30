class User < ApplicationRecord
  has_many :orders
  has_one :cart, dependent: :destroy
  has_many :notifications

  validates :email, :phone_number, presence: true
  validates :email, uniqueness: true
end
