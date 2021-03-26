class UsersController < ApplicationController
  before_action :set_users, only: [:followers, :following]

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def search_user
    @user_followee = User.find_by(username: params[:followee])
    if @user_followee
      if current_user.followers.include?(@user_followee)
        flash[:alert] = "User already followed."
        redirect_to tweets_path
      else
        follow = Relationship.create(follower: current_user, followee: @user_followee)
        flash[:notice] = "Now, your are following #{@user_followee.username}"
        redirect_to @user_followee
      end
    else
      flash[:alert] = "Input can't be blank."
      redirect_to tweets_path
    end
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
