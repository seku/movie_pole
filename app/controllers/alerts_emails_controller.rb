class AlertsEmailsController < ApplicationController
  
  def self.send_alerts 
    send_email_with_desirable_movies
    send_weekly_alerts
    #redirect_to genres_path  #this line should be removed 
  end
  
  def self.send_email_with_desirable_movies
    User.all.each do |user|
      @movies = []
      user.desirable_alerts.each do |alert|
        movie = Movie.find(alert.movie_id)
        if movie.torrents.size > 0
          @movies << movie
          alert.destroy
        end
      end
      send_desirable_email(user, @movies) if @movies.size > 0
    end
  end
  
  def self.send_weekly_alerts
    User.all.each do |user|
      @movies = []
      user.weekly_alerts.each do |alert|
        @movies << alert_movies(alert)
      end
      send_email(user, @movies) if @movies.size > 0
    end
  end

  def self.alert_movies(alert) #should be changed to finding only movies from this week 
    @genre = Genre.find(alert.genre_id) 
    @movies = @genre.movies.rated_with(alert.rating)
    @movies = @movies.limited(3)
    @movies = @movies.sorted_by("release_date", "desc")  
  end

  def self.send_email(user, movies)
    MoviesEmail.deliver_movies_email(user, movies)
    #flash[:notice] = "email sended" #should be removed
  end
  
  def self.send_desirable_email(user, movies)
    MoviesEmail.deliver_desirable_email(user, movies)
    #flash[:notice] = "#{user.email} email sended"  #should be removed
  end 
  

end

