require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Movie do
  fixtures :movies, :torrents, :genres
  
  before(:each) do
    @movie = movies(:first_movie)
  end
  
  it "should have correct title" do
    @movie.title.should == "Quarantine" 
  end
  it "should have correct imdb_id" do
    @movie.imdb_id.should == 1082868 
  end
  it "should have correct votes" do
    @movie.votes.should be_close(10520, 10)
  end
  it "should have correct rating" do
    @movie.rating.should == 6.2 
  end
  it "should sanitize title " do
    @sanitize_movie = Movie.create!(:title => " Trix ", :imdb_id => 1212)
    @sanitize_movie.title.should == "Trix"
  end
  it "should be serialized array" do
    movies(:first_movie).writers.should be_kind_of(Array)
  end
  it "should return valid date" do
    Movie.search_start_date.to_s.should == "2008-10-10" 
  end
  
  it "should save movie" do
    Movie.all.size.should == 2
    date = Date.new(2009, 01, 10)
    data_to_create_movie = [{:title => "robert", :imdb_id => 10, :rating => 5.0, :year => 2007, :votes => 1000, :writers => ["Tomek", "Jacek"], :directors => ["Jacek", "Tomek"],
:tagline => "cos tam", :plot => "ble ble", :poster => "brak", :official_site => "trix.pl", :genres => "comedy" }]
    Movie.bulk_save_movies(date, data_to_create_movie)
    Movie.all.size.should == 3
    Movie.last.title.should  == "robert"
    Movie.last.imdb_id.should == 10
    Movie.last.rating.should == 5.0
    Movie.last.year.should == 2007
    Movie.last.votes.should == 1000
    Movie.last.writers.should == ["Tomek", "Jacek"]
    Movie.last.directors.should == ["Jacek", "Tomek"]
    Movie.last.tagline.should == "cos tam"
    Movie.last.plot.should == "ble ble"  
    Movie.last.poster.should == "brak"
    Movie.last.official_site.should == "trix.pl"
    Movie.last.release_date.to_s.should == "2009-01-10"
    Movie.last.genres.name.should == "comedy"
  end    
    

  it { should have_many :desirable_alerts }
  it { should have_many(:users).through(:desirable_alerts) }
  it { should have_many :torrents }
  it { should have_and_belong_to_many :genres }
  it { should validate_uniqueness_of :imdb_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :imdb_id }
  it { should validate_numericality_of :votes }  
  it { should validate_numericality_of :rating }
  it { should validate_numericality_of(:year) }
  it { should have_named_scope(:most_voted).finding(:order => "movies.votes desc") }
  it { should have_named_scope(:only_torrents).finding(:conditions => ["torrents_count > 0"]) }
  it { should have_named_scope("rated_with(7.0)").finding(:conditions => ["rating >= ?", 7.0]) }
  #it { should_have_named_scope("sorted_by(title, desc)").finding(:order => "movies.rating desc") }
  it { should have_named_scope("limited(5)").finding(:limit => 5) }
end
