require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Genre do
  
  fixtures :genres, :movies
  
  before do
    @genre = genres(:two)
    @genre1 = genres(:six)
    @available = ["all", "action", "adventure", "animation", "biography", "comedy", "crime", "documentary", "drama", "family", "fantasy", "film_noir", "game_show", "history", "horror", "music", "musical", "mystery", "news", "reality_tv", "romance", "sci_fi", "short", "sport", "talk_show", "thriller", "war", "western"]
  end

  it "should have no movies" do
    @genre1.movies.should be_empty
  end
  it "should have 2 movies" do
    @genre.movies.size.should == 2
  end
  it "should have 1 movie" do
    genres(:three).movies.size.should == 1
  end
  
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  
  it "should return valid array" do
    Genre.available.should == @available
  end
  it "should return object array" do
    Genre.fetch_genres.should == @available
  end
  
  it "should return object array" do
    Genre.options_for_select.should be_kind_of(Array)
    Genre.options_for_select.size.should == 6
  end
  
end
