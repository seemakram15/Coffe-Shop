class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
