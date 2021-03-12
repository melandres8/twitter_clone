class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:followee_id])
    current_user.follow(user)
    redirect_to root_path
  end

  def destroy
    user = Relationship.find(params[:id]).followee
    current_user.unfollow(user)
    redirect_to root_path
  end
end
