class CompareTastesController < ApplicationController
  
  def show
    @compared_user = User.find(params[:id])
    @comparison = Vote.check_user(@compared_user, current_user)
  end
  
  def find_closest_users
    @users_array = Vote.analize_votes(params[:movie_id], params[:rating], current_user)
    if request.xhr?
      unless @users_array.nil?
        render :json => {:data => @users_array.sort_by{ |item| - item[:comparison_value] }[1..3] }
      else
        render :json => {:data => "undefined"}
      end
    end
  end

end
