module MoviesHelper

  def genre_name(genre_id)
    t("genres.#{Genre.find(genre_id).name}")
  end

  def imdb_url(imdb_id)
    "http://www.imdb.com/title/tt#{imdb_id}/"
  end

	def subtitles_url(lang, imdb_id)
	  lang_maps = {"pl" => "pol", "en" => "eng", "es" => "spa"}
    "http://www.opensubtitles.org/#{lang}/search/sublanguageid-#{lang_maps[lang]}/imdbid-#{imdb_id}"
	end
	
  def not_follwed_user?(user_id)  
	  !current_user.followed_users.include? User.find(user_id)  
	end	
end

