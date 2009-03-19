module IMDB
  class NowPlaying
    def movies(year, month, day)
      uri = "#{BASE_URI}/nowplaying/%04d/%02d/%02d" % [year, month, day]
      doc = Hpricot(open(uri, HEADERS)) # open-uri - biblioteka standardowa
      results = []
      (doc / "a.title").each do |a|
        result = {}
        match = a["href"].match(/\/title\/tt(\d+)/)  # match - dostępne w klasie String
        result[:imdb_id] = match[1] if match
        result[:title] = a.inner_html
        results << result unless result.empty?
      end
      { :query => { :year => year, :month => month }, :results => results }
    end
  end
end
