class Item < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items
  has_many :orders, through: :order_items
  has_many :carts, through: :cart_items

  validates :name, :price, presence: true
end
