# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :following, :followers]
  before_action :set_user, only: [:show, :following, :followers]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    # Additional logic as needed
  end

  def following
    @title = "Following"
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end