require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe IMDB::FullInformation, "with brokenflowers fixture" do

  before do
    @fi = IMDB::FullInformation.new
    @fi.stub!(:open_movie_file).and_return(open("/home/seku/repos/movie_pole/backends/imdb/spec/fixtures/brokenflowers.html"))
    @fi.stub!(:open_poster).and_return(open("/home/seku/repos/movie_pole/backends/imdb/spec/fixtures/brokenflowers_poster.html"))
    @fi.stub!(:open_official_site).and_return(open("/home/seku/repos/movie_pole/backends/imdb/spec/fixtures/brokenflowers_official_site.html"))
  end


  it "should parse HTML and return hash with results" do
    result = @fi.information("0412019")
    info = result[:result]
    
    info[:title].should  == "Broken Flowers"

    info[:year].should == "2005"
		info[:rating].should == 7.3
    info[:imdb_votes].should == 30775
    info[:directors].should == ["Jim Jarmusch"]
    info[:writers].should == ["Jim Jarmusch", "Bill Raden"]
    info[:official_site].should == "http://www.bacfilms.com/site/brokenflowers/"
    #info[:release_date].should == "16 September 2005" 
    info[:genres].should == ["Comedy", "Drama", "Mystery"]
    info[:poster].should == "http://ia.media-imdb.com/images/M/MV5BMTQ4OTk1MTYxM15BMl5BanBnXkFtZTcwMTYwNjAzMQ@@._V1._SX270_SY400_.jpg"
    info[:tagline].should == "Sometimes life brings some strange surprises."
    #info[:poster].should == "http://ia.media-imdb.com/images/M/MV5BMTQ4OTk1MTYxM15BMl5BanBnXkFtZTcwMTYwNjAzMQ@@._V1._SX270_SY400_.jpg"
    info[:plot].should == "As the devoutly single Don Johnston is dumped by his latest girlfriend, he receives an anonymous pink letter informing him that he has a son who may be looking for him. The situation causes Don to examine his relationships with women instead of moving on to the next one, and he embarks on a cross-country search for his old flames who might possess clues to the mystery at hand."      

  end
end

describe IMDB::FullInformation, "with Madea Goes to Jail fixture" do   
  before do
    @fi = IMDB::FullInformation.new
    @fi.stub!(:open_movie_file).and_return(open("/home/seku/repos/movie_pole/backends/imdb/spec/fixtures/madeagoestojail.html"))
    @fi.stub!(:open_poster).and_return(open("/home/seku/repos/movie_pole/backends/imdb/spec/fixtures/madeagoestojail_poster.html"))
    
  end


  it "should parse HTML and return hash with results" do
    result = @fi.information("1142800")
    info = result[:result]
    
    info[:title].should  == "Madea Goes to Jail"

    info[:year].should == "2009"
		info[:rating].should == 2.8
    info[:imdb_votes].should == 1562
    info[:directors].should == ["Tyler Perry"]
    info[:writers].should == ["Tyler Perry"]
    info[:release_date].should == Date.new(2009, 2, 20) 
    info[:genres].should == ["Comedy", "Crime", "Drama"]
    info[:tagline].should == ""
    info[:poster].should == "http://ia.media-imdb.com/images/M/MV5BMTk1Nzg0MDIxM15BMl5BanBnXkFtZTcwMjk5ODkyMg@@._V1._SX270_SY400_.jpg"
    info[:plot].should == "Mischievous grandma Madea lands in jail, where she meets a variety of mixed-up characters."      

  end
end
