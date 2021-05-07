class UsersController < ApplicationController
  include UserScoped

  def show
    @tweets = @user.tweets.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def search_user
    return redirect_to root_path if params[:followee].blank?
    @to_follow = User.find_by(username: params[:followee])
    return redirect_to root_path, alert: "Username does not exists." if !@to_follow
    return redirect_to root_path, alert: "Invalid operation." if @to_follow == current_user

    return redirect_to root_path, alert: "User already followed." if current_user.following.include?(@to_follow)

    follow = Relationship.create(follower: current_user, followee: @to_follow)
    redirect_to user_path(@to_follow.username), notice: "Now, your are following #{@to_follow.username}"
  end
end
