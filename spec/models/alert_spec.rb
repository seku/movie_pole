require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe GenresController do
  
    it "should show genres" do 
      get "index" 
      #assigns[:genres]
      respond_with :success
      response.should render_template("index")
    end
   
end
