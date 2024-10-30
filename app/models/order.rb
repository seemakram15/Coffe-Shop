class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  enum status: { pending: 0, completed: 1, cancelled: 2 }

  after_update :notify_user, if: :saved_change_to_status?

  private

  def notify_user
    message = "Your order status has been updated to #{status}."
    user.notifications.create(message: message, read: false)
  end
end
