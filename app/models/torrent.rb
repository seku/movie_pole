class Torrent < ActiveRecord::Base
  belongs_to :movie, :counter_cache => true
  @torrent = Mininova.new
	Torrent_limit_size = 500000000
	def self.fetch_torrents
    puts "..update_all_torrents.."
    torrents = Movie.all.map do |m| 
    	#unless m.torrents.size > 0
    	results =	@torrent.from_imdb(m.imdb_id)
    	results.each do |t|
        if t[:size] > Torrent_limit_size
        	m.torrents.create!(:url => t[:url], :size => t[:size], :title => t[:title], :leechers => t[:leechers], :seeders => t[:seeds])
      	end
      end
    end    
  end


end
