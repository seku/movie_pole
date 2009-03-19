module MoviesHelper

  def imdb_url(imdb_id)
    "http://www.imdb.com/title/tt#{imdb_id}/"
  end
	def subtitles_url(lang, imdb_id)
	  lang_maps = {"pl" => "pol", "en" => "eng", "es" => "spa"}
    "http://www.opensubtitles.org/#{lang}/search/sublanguageid-#{lang_maps[lang]}/imdbid-#{imdb_id}"
	end
end

