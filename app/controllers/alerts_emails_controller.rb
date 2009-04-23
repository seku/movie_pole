class AlertsEmailsController < ApplicationController
  def index
    current_user.alerts.each do |alert|
      alert.movies = alert_movies(alert)
    end
    send_email(current_user)
    redirect_to user_path(current_user)
  end
  
  def alert_movies(alert)
    @genre = Genre.find(alert.genre_id) 
    @movies = @genre.movies.rated_with(alert.rating)
    @movies = @movies.only_torrents.limited(3)
    @movies = @movies.sorted_by("release_date", "desc")
  end

  def send_email(user)
    MoviesEmail.deliver_movies_email(user)
    flash[:notice] = "email sended"
  end
end
