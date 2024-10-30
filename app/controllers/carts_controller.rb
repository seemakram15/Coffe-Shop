# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_user, only: %i[show create update]
  before_action :set_cart, only: %i[show update]

  def show
    @cart_items = @cart.cart_items
  end

  def create
    item = Item.find(params[:item_id])

    @user.cart.add_item(item)
    redirect_to user_cart_path(@user), notice: "#{item.name} has been added to your cart."
  rescue ActiveRecord::RecordNotFound
    redirect_back fallback_location: root_path, alert: 'Item not found.'
  end

  def update
    item = Item.find(params[:item_id])
    quantity = params[:quantity].to_i

    cart_item = @cart.cart_items.find_or_initialize_by(item: item)
    cart_item.quantity += quantity

    if cart_item.quantity <= 0
      cart_item.destroy
      notice = "#{item.name} removed from the cart."
    else
      cart_item.save!
      notice = "#{item.name} quantity updated."
    end

    redirect_back fallback_location: user_cart_path(@user), notice: notice
  rescue ActiveRecord::RecordNotFound
    redirect_back fallback_location: root_path, alert: 'Item not found.'
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(e.message)
    redirect_back fallback_location: user_cart_path(@user), alert: 'Failed to update cart item.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'User not found.'
  end

  def set_cart
    @cart = @user.cart || @user.create_cart
  end
end
