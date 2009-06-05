class AlertsEmailsController < ApplicationController
  
  def index 
    send_email_with_desirable_movies
    send_weekly_alerts
    redirect_to user_path(current_user)  #this line should be removed 
  end
  
  def send_email_with_desirable_movies
    User.all.each do |user|
      @movies = []
      user.desirable_alerts.each do |alert|
        movie = Movie.find(alert.movie_id)
        if movie.torrents.count > 0
          @movies << movie
          alert.destroy
        end
      end
      send_desirable_email(user, @movies) if @movies.count > 0
    end
  end
  
  def send_weekly_alerts
    User.all.each do |user|
      @movies = []
      user.weekly_alerts.each do |alert|
        @movies << alert_movies(alert)
      end
      send_email(user, @movies) if @movies.count > 0
    end
  end

  def alert_movies(alert) #should be changed to finding only movies from this week 
    @genre = Genre.find(alert.genre_id) 
    @movies = @genre.movies.rated_with(alert.rating)
    @movies = @movies.only_torrents.limited(3)
    @movies = @movies.sorted_by("release_date", "desc")  
  end

  def send_email(user, movies)
    MoviesEmail.deliver_movies_email(user, movies)
    flash[:notice] = "email sended" #should be removed
  end
  
  def send_desirable_email(user, movies)
    MoviesEmail.deliver_desirable_email(user, movies)
    flash[:notice] = "#{user.email} email sended"  #should be removed
  end 
  

end
