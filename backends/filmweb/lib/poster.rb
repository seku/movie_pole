require "rubygems"
require "open-uri"
require "hpricot"

module Filmweb
  
  BASE_URI = "http://www.filmweb.pl/szukaj?q="

  class Poster
    
    def self.information(movie_title)
      movie_title = movie_title.gsub(/ /,"+")
      link_to_movie = search_for_movie(movie_title)
      get_poster_link(link_to_movie)
      #get_polish_plot(link_to_movie) 
    end

    protected

    def self.search_for_movie(movie_title)
      doc = Hpricot(open("#{BASE_URI}#{movie_title}&c=film"))
      link_to_movie = (doc / "a.searchResultTitle").first.attributes["href"]
    end
    
    def self.get_poster_link(link_to_movie)
      doc = Hpricot(open(link_to_movie))
      link_to_poster = doc / "div.film-poster" / "img"
      link_to_poster = link_to_poster.first.attributes["src"]    
    end
    
    def self.get_polish_plot(link_to_movie)
      doc = Hpricot(open(link_to_movie))
      polish_plot = doc / "div.film-spaced" / "p"
      polish_plot = polish_plot.inner_text.strip.gsub(/\t(\w|\W)*/, "")
    end
  end
end
