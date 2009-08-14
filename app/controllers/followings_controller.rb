class FollowingsController < ApplicationController
  
  def create
    current_user.followed_users << User.find(params[:id])
    if request.xhr?
      render :json => { :flash => "Added to your followed users list"}
    end 
  end
  
  def destroy
    current_user.followed_users.delete(User.find(params[:id]))
    if request.xhr?
      render :json => { :flash => "User removed from your list", :id => params[:id]}
    end  
  end
end
