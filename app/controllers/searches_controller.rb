class SearchesController < ApplicationController
  def index
    @sort = params[:sort_by].nil? ? "release_date" : params[:sort_by] 
	  conditions = {}
	  (@sort == "title") ? (conditions[:sort_mode] = :asc) : (conditions[:sort_mode] = :desc)
	  conditions[:order] = @sort.to_sym
	  conditions[:page] = params[:page]
	  conditions[:per_page] = per_page
	  conditions[:conditions] = { :genre_ids => params[:genre_id] }
	 	conditions[:conditions][:rating] = params[:rating].to_f..10.0 
    conditions[:without] = { :torrents_count => 0 }  unless params[:without]
    @movies = Movie.search(params[:query], conditions)
  end
  
  def autocomplete
    @movies = Movie.search(params[:query])
    render :json => @movies.to_json(:only => ["title", "id"])
  end

  def suggest
    @movies = Movie.search(params[:query])
    @respond = @movies.map{ |movie| movie.title }  
    render  :json => [params[:query], @respond]
  end

end
