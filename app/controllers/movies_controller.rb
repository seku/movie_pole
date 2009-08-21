class MoviesController < ApplicationController
	
	def index
    @genre_id = params[:genre_id]
    @genre = Genre.find(params[:genre_id], :include => { :movies => :torrents})
    @movies = @genre.movies.rated_with(params[:rating] || 1)
    @movies = @movies.only_torrents unless params[:without]
    @movies = @movies.sorted_by((params[:sort_by] || "release_date"), (@sort_mode[params[:sort_by]] || "desc"))
    @movies = @movies.paginate :page => params[:page], :per_page => per_page
  end
  
  def show
    @genre_id = params[:genre_id]
    @user = current_user
    @movie = Movie.find(params[:id], :include => :torrents) 
    if current_user
      @pole_rating = current_user.votes.find_by_movie_id(params[:id]) ? current_user.votes.find_by_movie_id(params[:id]).user_rating : 0
    end
    if @pole_rating
      @users_array = Vote.analize_votes(params[:id], @pole_rating, current_user)
      unless @users_array.nil? 
        @users_array.sort_by{ |item| - item[:comparison_value] }[1..3]
      end
    end
  end
  
end
