# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'User created successfully.'
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @orders = @user.orders.includes(order_items: :item)
  rescue ActiveRecord::RecordNotFound => e
    handle_not_found(e)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
  end

  def handle_not_found(exception)
    Rails.logger.error(exception.message)
    redirect_to root_path, alert: 'User not found.'
  end
end
