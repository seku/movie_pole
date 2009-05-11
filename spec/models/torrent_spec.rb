require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Torrent do
  fixtures :movies, :torrents

  before do
    @torrent = torrents(:one)
    @torrent4 = torrents(:four)
  end
  
  it "should have correct title" do
    @torrent.title.should == "Quarantine 2008 DvDRip-FxM"
  end
  it "should have correct size" do
    @torrent.size.should == 734045143 
  end
  it "should have correct seeders count" do
    @torrent.seeders.should == 327 
  end
  it "should have valid size" do
    @torrent4.size.should == 400300200
  end
  
  it {  should belong_to :movie }

 
end
