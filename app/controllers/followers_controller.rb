class FollowersController < ApplicationController
  include UserScoped

  def show
    @user_followers = @user.followers.order("username ASC").paginate(page: params[:page], per_page: 10)
  end
end
