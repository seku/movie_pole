require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe GenresController, "test" do
  fixtures :all  
  
  before(:each) do
    @genres = mock_model(Genre)
    Genre.stub!(:find).and_return(@genres)
  end
  
  it "should receive genre object" do
    Genre.should_receive(:find).and_return(@genres)
    get :index
  end 

  it "action index should response with success" do 
    get :index 
    respond_with :success
  end
  
  it "shoul render tempate" do
    get :index
    response.should render_template("index")   
  end
  
  it "should assign genres for the view" do
    get :index
    assigns[:genres].should equal(@genres)
  end

end
