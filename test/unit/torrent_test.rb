require 'test/test_helper'

class TorrentTest < ActiveSupport::TestCase
  fixtures :movies, :torrents
  context "Arguments" do
    setup do
      @torrent = torrents(:one)
    end
    
    should "have correct title" do
      assert_equal "Quarantine 2008 DvDRip-FxM", @torrent.title
    end
    should "have correct size" do
      assert_equal 734045143, @torrent.size
    end
    should "have correct seeders count" do
      assert_equal 327, @torrent.seeders
    end
  end
  
  
  context "relationships" do
    setup do
      @torrent = torrents(:one)
    end
    
    should_belong_to :movie

  end
  
end
