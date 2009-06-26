class MoviesController < ApplicationController
	def index
    @genre = Genre.find(params[:genre_id], :include => { :movies => :torrents})
    @movies = @genre.movies.rated_with(params[:rating] || 1)
    @movies = @movies.only_torrents unless params[:without]
    @movies = @movies.sorted_by((params[:sort_by] || "release_date"), (@sort_mode[params[:sort_by]] || "desc"))
    @movies = @movies.paginate :page => params[:page], :per_page => per_page
  end
  def show
    @movie = Movie.find(params[:id], :include => :torrents) 
  end
  
end
