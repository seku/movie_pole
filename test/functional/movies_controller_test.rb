require 'test/test_helper'

class MovieTest < Test::Unit::TestCase
  fixtures :movies
  def setup
    @controller = MoviesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :index" do
    setup { get :index, { :genre_id => 3 } }
    
    should_assign_to :sort_by, :rating
    should_respond_with :success
    should_render_template :index
   
    should "contain forms" do
      assert_select "form", true, "This page must contain forms"
    end


  end
  
end
