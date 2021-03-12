class UsersController < ApplicationController
  before_action :set_users, only: [:followers, :following]

  def show
  end

  def followers
  end

  def following
  end

  private

  def set_users
    @users = User.all.order("name ASC").paginate(page: params[:page], per_page: 10)
  end
end
