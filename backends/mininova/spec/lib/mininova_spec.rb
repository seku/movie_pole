require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Mininova do
  
  before do
    @mininova = Mininova.new
    @mininova.stub!(:open).and_return(open(File.dirname(__FILE__) + "/../fixtures/madea.html"))
  end
  
  it "should ask mininova for torrents sorted by seeds" do
    # Mock open-uri open call.
    @mininova.should_receive(:open).with("http://www.mininova.org/search/foo/seeds").and_return("a tag soup")
    @mininova.search("foo")
  end
  
  it "should return a result hash with :query and :results" do
    @mininova.should_receive(:open).and_return("a tag soup")
    search = @mininova.search("foo")
    search[:query].should == "foo"
    search[:results].should be_kind_of(Array)
  end
 
  it "should return torrents features" do
    results = @mininova.from_imdb("1142800")
    
    torrent1 = results[0]
    torrent1[:url].should == "http://www.mininova.org/get/2311295"
    torrent1[:title].should == "Madea Goes To Jail TS XVID-PrisM-NoRar¤"
    torrent1[:seeds].should == "1530"
    torrent1[:size].should == 862191616
    torrent1[:leechers].should == "756"
    
    torrent2 = results[1]
    torrent2[:url].should == "http://www.mininova.org/get/2311996"
    torrent2[:title].should == "Madea Goes To Jail TS XVID-PrisM--cgaurav™--"
    torrent2[:seeds].should == "198"
    torrent2[:size].should == 862191616
    torrent2[:leechers].should == "101"
    
    torrent3 = results[2]
    torrent3[:url].should == "http://www.mininova.org/get/2320114"
    torrent3[:title].should == "Madea Goes To Jail TS XVID-PrisM { Speed.cd }"
    torrent3[:seeds].should == "38"
    torrent3[:size].should == 862191616
    torrent3[:leechers].should == "11"
  end
  
end
