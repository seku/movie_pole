class MoviesController < ApplicationController
	
	def index
    @genre_id = params[:genre_id]
    @genre = Genre.find(params[:genre_id], :include => { :movies => :torrents})
    @movies = @genre.movies.rated_with(params[:rating] || 1)
    @movies = @movies.only_torrents unless params[:without]
    @movies = @movies.sorted_by((params[:sort_by] || "release_date"), (@sort_mode[params[:sort_by]] || "desc"))
    @movies = @movies.paginate :page => params[:page], :per_page => per_page
    @fuser_votes = fusers_votes if current_user
  end
  
  def fusers_votes
    @fuser_votes = []
    current_user.followed_users.each do |fu|
      fu.votes.each do |v|
        @fuser_votes << {:date => v.updated_at.strftime("%d.%m.%Y"), :fuser => fu, :fuser_rating => v.user_rating, :fuser_photo => fu.gravatar_url(:default => "wavatar", :size => 30), :movie_id => Movie.find(v.movie_id).id, :movie_title => resize_title(Movie.find(v.movie_id).title) }
      end
    end  
    @fuser_votes_size = @fuser_votes.size
    @fuser_votes = @fuser_votes.sort_by {|v| v[:date]}.reverse().paginate :page => params[:page], :per_page => 10
    if request.xhr?
      render :json => @fuser_votes
    else
      [@fuser_votes, @fuser_votes_size]
    end    
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
      @users_array.sort_by{ |item| - item[:comparison_value] }[1..3] if @users_array#unless @users_array.nil? 
    end
  end
  

  
  protected
  
  def resize_title(title)
    if title.length > 14
      title[0..12] + ".."
    else
      title
    end
  end
end
