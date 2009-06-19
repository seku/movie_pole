class MoviesEmail < ActionMailer::Base
  #include ActionController::UrlWriter
  #default_url_options[:host] = "localhost:3000" #needed for test
   
  def movies_email(user, movies)
    subject       "Send list of movies"
    from          "trix@trix.megiteam.pl"
    recipients    user.email
    sent_on       Time.now
    body          :user => user, :movies => movies
  end

  def desirable_email(user, movies)
    subject       "Send list of movies"
    from          "trix@trix.megiteam.pl"
    recipients    user.email
    sent_on       Time.now
    body          :user => user, :movies => movies
  end
  
  def invitation_email(user)
    subject       "Welkomme in Movie Pole"
    from          "trix@trix.megiteam.pl"
    recipients    user.email
    sent_on       Time.now
    body          :user => user    
  end
  
  helper_method :torrent_url, :subtitles_url, :genre
  
  def genre(id)
    Genre.find(id).name
  end
  
  def torrent_url(torrent)
    "http://www.mininova.org#{torrent.url}"
  end

	def subtitles_url(lang, imdb_id)
	  lang_maps = {"pl" => "pol", "en" => "eng", "es" => "spa"}
    "http://www.opensubtitles.org/#{lang}/search/sublanguageid-#{lang_maps[lang]}/imdbid-#{imdb_id}"
	end
end
