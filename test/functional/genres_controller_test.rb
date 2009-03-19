require 'test/test_helper'

class GenreTest < Test::Unit::TestCase
  def setup
    @controller = GenresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :index" do
    setup { get :index }
    
    should_assign_to :genres
    should_respond_with :success
    should_render_template :index
   
    should "contain forms" do
      assert_select "form", true, "This page must contain forms"
    end


  end
  
end
