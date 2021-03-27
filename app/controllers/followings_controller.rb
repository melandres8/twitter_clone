class FollowingsController < ApplicationController
  include UserScoped

  def show
    @user_following = @user.following.order("name ASC").paginate(page: params[:page], per_page: 10)
  end
end
