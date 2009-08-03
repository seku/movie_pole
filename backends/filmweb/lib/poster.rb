require "rubygems"
require "open-uri"
require "hpricot"

module Filmweb
  
  BASE_URI = "http://www.fandango.com/GlobalSearch.aspx?repos=Movies&tab=Movies+Video&q="

  class Poster
    
    def self.information(movie_title)
      movie_title = movie_title.gsub(/ /,"+")
      begin
        link_to_movie = search_for_movie(movie_title)
        get_poster_link(link_to_movie)
      rescue
        puts "Nil Class for #{movie_title}"
      end
      #get_polish_plot(link_to_movie) 
    end
    
    def self.update(id, link_to_movie)
      @movie = Movie.find(id)
      @movie.update_attributes(:poster => get_poster_link(link_to_movie))
    end
    
    protected

    def self.search_for_movie(movie_title)
      doc = Hpricot(open("#{BASE_URI}#{movie_title}"))
      link_to_movie = (doc / "ul.results" / "li.first" / "h5" / "a").first.attributes["href"]
    end
    
    def self.get_poster_link(link_to_movie)
      doc = Hpricot(open(link_to_movie))
      link_to_poster = doc / "div#image" / "a" / "img"
      link_to_poster = link_to_poster.first.attributes["src"]    
    end
    
    def self.get_polish_plot(link_to_movie)
      doc = Hpricot(open(link_to_movie))
      polish_plot = doc / "div.film-spaced" / "p"
      polish_plot = polish_plot.inner_text.strip.gsub(/\t(\w|\W)*/, "")
    end
  end
end
