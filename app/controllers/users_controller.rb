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
          redirect_to root_path, alert: "User already followed."
        elsif !@to_follow
          redirect_to root_path, alert: "Username does not exists."
        else
          follow = Relationship.create(follower: current_user, followee: @to_follow)
          redirect_to user_path(@to_follow.username), notice: "Now, your are following #{@to_follow.username}"
        end
      else
        redirect_to root_path, alert: "Invalid operation."
      end
    end
  end
end
