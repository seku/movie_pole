module GenresHelper
  
  def genre_movies_torrents(genre)
    genre_movies_torrents = 0
    genre.movies.each{|movies| genre_movies_torrents += 1 if (movies.torrents.size > 0) }
    genre_movies_torrents
  end
  
end
