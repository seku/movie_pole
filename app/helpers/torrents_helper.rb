module TorrentsHelper

  def torrent_url(torrent)
    "http://www.mininova.org#{torrent.url}"
  end
  
end
