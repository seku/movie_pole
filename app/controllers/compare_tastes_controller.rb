class CompareTastesController < ApplicationController
  
  def show
    @compared_user = User.find(params[:id])
    @compared_user_votes = compared_user_votes
    @comparison = Vote.check_user(@compared_user, current_user)
  end
  
  def compared_user_votes
    @compared_user_votes = []
    User.find(params[:id]).votes.each do |v|
      @compared_user_votes << {:movie_title => Movie.find(v.movie_id).title, :movie_poster => Movie.find(v.movie_id).poster, :movie_id => Movie.find(v.movie_id).id, :compared_user_rating => v.user_rating, :date => v.updated_at.strftime("%d.%m.%Y"), :current_user_rating => rated?(v.movie_id), :rel => voted?(v.movie.id)}
    end
    @compared_user_votes_size = @compared_user_votes.size
    @compared_user_votes = @compared_user_votes.sort_by{|v| v[:date]}.reverse.paginate :page => params[:page], :per_page => 10
    if request.xhr?
      render :json => @compared_user_votes
    else
      [@compared_user_votes, @compared_user_votes_size]
    end
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
  
  protected
  
  def voted?(id)
    current_user_voted?(id) ? "" : "voted"
  end
  
  def rated?(id)
    current_user_voted?(id) ? t('user.vote.not') : current_user.votes.find_by_movie_id(id).user_rating
  end
  
  def current_user_voted?(id)
    current_user.votes.find_by_movie_id(id).nil?
  end

end
