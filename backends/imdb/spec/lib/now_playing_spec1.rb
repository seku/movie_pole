require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe IMDB::NowPlaying, "with 2009-02 fixture" do

  before do
    @now_playing = IMDB::NowPlaying.new
    @now_playing.stub!(:open).and_return(open(File.dirname(__FILE__) + "/../fixtures/2009-02.html"))
  end

  it "should parse HTML and return hash with query" do
    result = @now_playing.movies(2009, 02)
    result.should include(:query)
  end

  it "should parse HTML and return hash with results" do
    result = @now_playing.movies(2009, 02)
    results = result[:results]
    results.should include(:imdb_id => "1229827", :title => "Jonas Brothers: The 3D Concert Experience")
    results.should include(:imdb_id => "0924129", :title => "Crossing Over")
    results.should include(:imdb_id => "0891592", :title => "Street Fighter: The Legend of Chun-Li")
    results.should include(:imdb_id => "1142800", :title => "Madea Goes to Jail")
    results.should include(:imdb_id => "0327597", :title => "Coraline")
    results.should include(:imdb_id => "1001508", :title => "He's Just Not That Into You")
    results.should include(:imdb_id => "1010048", :title => "Danny Boyle")
    results.should include(:imdb_id => "0758746", :title => "Friday the 13th")
    results.should include(:imdb_id => "1114740", :title => "Paul Blart: Mall Cop") 
  end
end
