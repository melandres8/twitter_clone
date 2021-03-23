class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def followers
    @user_followers = current_user.followers.order("name ASC").paginate(page: params[:page], per_page: 10)
  end

  def following
    @user_following = User.all.order("name ASC").paginate(page: params[:page], per_page: 4)
  end
end
