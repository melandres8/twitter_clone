class UsersController < ApplicationController
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
    @user_followers = current_user.followers.order("username ASC").paginate(page: params[:page], per_page: 10)
  end

  def following
    @user_following = current_user.following.order("name ASC").paginate(page: params[:page], per_page: 10)
  end
end
