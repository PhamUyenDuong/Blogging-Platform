# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    # Additional logic as needed
  end

  def send_follow_request
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to users_path, notice: 'Follow request sent!'
  end

  def accept_follow_request
    @user = User.find(params[:id])
    current_user.accept_follow_request(@user)
    redirect_to users_path, notice: 'Follow request accepted!'
  end
end
