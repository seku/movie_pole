require 'rubygems'
require 'hpricot'
require 'open-uri'

class Mininova
  
  BASE_URL = "http://www.mininova.org"
  
  # Hit following address and observe.
  # http://www.mininova.org/search/californication%20s02e09/seeds
  # http://www.mininova.org/imdb/?imdb=434343
  #fetch_results("http://www.mininova.org/imdb/1103275/seeds")
  def search(query)
    source = "#{BASE_URL}/search/#{URI.encode(query)}/seeds"
    results = fetch_results(source)    
    { :query => query, :results => results }
  end

  def from_imdb(imdb_id) 
    source = "#{BASE_URL}/imdb/#{imdb_id}/seeds"
    results = fetch_results(source)
  end

  def fetch_results(source) #return download_path file 
    doc = Hpricot(open(source))
    row = doc / "table.maintable" / "tr"
    long = (row.length < 4) ? row.length : 4 #fetch only 3 torrents for each movie 
    torrents = (1...long).to_a.map do |i|
     	url = parse_url(row[i])
    	size = parse_size(row[i])
    	title = parse_title(row[i])
    	seeds = parse_seeds(row[i])
    	leechers = parse_leechers(row[i])
    	{ :title => title, :url => url, :size => size, :seeds => seeds, :leechers => leechers } 
    end
  end
  
  def parse_url(row)
  	(row / "a.dl").first.attributes['href']
  end 
  
  def parse_size(row)
  	cell = (row / "td")
  	number = cell[2].inner_text 
  	if number.include? "MB"
  		size = number.match(/(\d+).(\d+)/)
 			((size.to_s).to_f * 1048576).to_i
 		else
 			size = number.match(/(\d+).(\d+)/)
 			((size.to_s).to_f * 1073741824).to_i
 		end 
  end
  
  def parse_seeds(row)
  	seeds = (row / "td")
  	seeds[3].inner_text 
  end
  
  def parse_leechers(row)
  	leechers = (row / "td")
  	leechers[4].inner_text 
  end
  
  def parse_title(row)
  	cell = (row / "td")
  	title = (cell[1] / "a")
  	index = title.size
  	title[index - 2].inner_text
  end
end





