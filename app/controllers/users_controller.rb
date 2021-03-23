class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def followers
    @user_followers = current_user.followers.order("username ASC").paginate(page: params[:page], per_page: 10)
  end

  def following
    @user_following = current_user.following.order("name ASC").paginate(page: params[:page], per_page: 10)
  end
end
