# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_user, only: %i[new create]

  def new
    @categories = Category.all
    @cart = @user.cart || @user.create_cart
  end

  def create
    @cart = @user.cart

    if @cart.cart_items.empty?
      redirect_to new_user_order_path(@user), alert: 'Your cart is empty.'
      return
    end

    ActiveRecord::Base.transaction do
      order = @user.orders.create!(total_amount: @cart.grand_total)

      @cart.cart_items.each do |cart_item|
        order.order_items.create!(
          item: cart_item.item,
          quantity: cart_item.quantity
        )
      end

      @cart.destroy
      @user.notifications.create!(
        message: "Your order has been placed with a total of $#{order.total_amount}"
      )
    end

    redirect_to root_path, notice: 'Order placed successfully!'
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(e.message)
    redirect_to new_user_order_path(@user), alert: 'Failed to place the order. Please try again.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'User not found.'
  end
end
