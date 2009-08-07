class CompareTastesController < ApplicationController
  
  def find_closest_users
    @votes = Vote.on_movie(params[:movie_id]).rated_with(params[:rating].to_i).reject{|v| v.user_id == current_user.id} #test do tego !!!
    unless @votes.empty?
      @users_array = []
      @votes.each do |vote|
        @user = User.find(vote.user_id)
        @users_array << {:user_id => @user.id, :user => @user.login, :comparison_value => check_user(@user)}
      end
    end
    if request.xhr?
      unless @users_array.nil?
        render :json => {:data => @users_array.sort_by{ |item| - item[:comparison_value] }[1..3] }
      else
        render :json => {:data => "pp"}
      end
    end
  end
  
  def show
    @compared_user = User.find(params[:id])
    check_user(@compared_user)
  end
  
  def check_user(user)
    @movie_ids = []
    current_user.votes.each {|vote| @movie_ids << vote.movie_id}
    user.votes.each do |vote|
      unless @movie_ids.include? vote.movie_id
        @movie_ids << vote.movie_id
      end
    end
    @comparison = check_taste(@movie_ids, user)  
  end

  def check_taste(movie_ids, compared_user)
    unless movie_ids.empty?
      @sum = 0
      movie_ids.each do |movie_id|
        if current_user.votes.find_by_movie_id(movie_id) && compared_user.votes.find_by_movie_id(movie_id)
          @sum += 13 - (compared_user.votes.find_by_movie_id(movie_id).user_rating - current_user.votes.find_by_movie_id(movie_id).user_rating).abs
        end 
      end
      round_comparison(@sum * 100 / (movie_ids.size * 10).to_f)
    else
      0
    end 
  end
  
  def round_comparison(comparison)
    (comparison * 100).round.to_f / 100
  end
end
