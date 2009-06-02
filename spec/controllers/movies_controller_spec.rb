require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MoviesController, "action index" do
  
  before(:each) do
    @genre = mock_model(Genre)
    @movies = mock_model(Movie)
    @movies1 = mock_model(Movie)
    @movies2 = mock_model(Movie)
    @movies3 = mock_model(Movie)
    @movies4 = mock_model(Movie)
    
    Genre.stub!(:find).and_return(@genre)
    @genre.stub!(:movies).and_return(@movies)
    @movies.stub!(:rated_with).with(1.0).and_return(@movies1)
    @movies1.stub!(:only_torrents).and_return(@movies2)
    @movies2.stub!(:sorted_by).with("release_date", "desc").and_return(@movies3)
    @movies3.stub!(:paginate).and_return(@movies4)
    #@movies4.stub!(:total_pages).and_return(0)
  end
  
  it "should receive movies" do
    Genre.should_receive(:find).and_return(@genre)
    @genre.should_receive(:movies).and_return(@movies)
    @movies.should_receive(:rated_with).with(1.0).and_return(@movies1)
    @movies1.should_receive(:only_torrents).and_return(@movies2)
       
    get :index
  end
  
  it "should render template " do
    get :index
    response.should be_success
    response.should render_template('movies/index')
  end
  
  it "should assign movies for the view" do
    get :index
    assigns[:movies].should equal(@movies4)
  end
end

























