class UsersController < ApplicationController
  include UserScoped

  def show
    @tweets = @user.tweets.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def search_user
    if params[:followee].present?
      @to_follow = User.find_by(username: params[:followee])
      if @to_follow != current_user
        if current_user.following.include?(@to_follow)
          flash[:alert] = "User already followed."
          redirect_to root_path
        else
          follow = Relationship.create(follower: current_user, followee: @to_follow)
          flash[:notice] = "Now, your are following #{@to_follow.username}"
          redirect_to user_path(@to_follow.username)
        end
      else
        flash[:alert] = "Invalid operation."
        redirect_to root_path
      end
    end
  end
end
