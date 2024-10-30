# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  validates :user_id, presence: true


  def add_item(item)
    existing_order_item = cart_items.find_by(item_id: item.id)

    if existing_order_item
      existing_order_item.increment!(:quantity)
    else
      cart_items.create(item: item, quantity: 1)
    end
  end

  def grand_total
    cart_items.sum { |ci| ci.item.price * ci.quantity }
  end
end
