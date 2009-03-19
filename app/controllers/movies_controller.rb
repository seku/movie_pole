class MoviesController < ApplicationController
	def index
    @sort_by = Sort.all.map{ |s| [t("sort.#{s.name}"), s.name] } 
    @rating = %w{1.0 5.0 6.0 7.0 8.0 9.0}
    @genre = Genre.find(params[:genre_id]) 
    @movies = @genre.movies.rated_with(params[:rating] || 1)
    @movies = @movies.only_torrents unless params[:without]
    @sort = params[:sort_by].nil? ? "release_date" : params[:sort_by] 
    @movies = (@sort.include? "title") ? @movies.title : @movies.sorted_by(@sort)
    @movies = @movies.paginate :page => params[:page], :per_page => pn
  end
  def show
    @movie = Movie.find(params[:id]) 
  end
  
end
