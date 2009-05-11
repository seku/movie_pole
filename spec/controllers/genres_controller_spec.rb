require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe GenresController, "test" do
  fixtures :all  
  describe "Get index" do
    it "should show genres" do 
      get :index 
      #status.should.be :success
      #assigns[:genres]
      #respond_with :success
      #response.should render_template("index")
    end
  end
end
