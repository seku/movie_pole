require 'test/test_helper'

class SearchTest < Test::Unit::TestCase
  def setup
    @controller = SearchesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET to :index" do
    setup { get :index, { :search => "release_date", :query => "of" } }
    
    should_assign_to :sort_by
    should_respond_with :success
    should_render_template :index
   
    should "contain forms" do
      assert_select "form", true, "This page must contain forms"
    end


  end
  
end
