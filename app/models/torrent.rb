class Torrent < ActiveRecord::Base
  belongs_to :movie, :counter_cache => true
  @torrent = Mininova.new
	Torrent_limit_size = 500000000

	
	def self.fetch_torrents
    puts "..update_all_torrents.."
    torrents = Movie.all.map do |movie| 
      if (movie.release_date > (Date.today - 1.year))
        movie.torrents.destroy_all
      end
      get_torrents_for_movie(movie)
    end    
  end
  
  def self.get_torrents_for_movie(movie)
    unless movie.torrents.size > 2   #0 or 3 ??
  	  puts movie.title
  	  results =	@torrent.from_imdb(movie.imdb_id)
  	  results.each do |t|
        if t[:size] > Torrent_limit_size
      	  movie.torrents.create!(:url => t[:url], :size => t[:size], :title => t[:title], :leechers => t[:leechers], :seeders => t[:seeds])
    	  end
      end
    end
  end  
  
end
