require 'test/test_helper'

class MoviesTest < ActionController::IntegrationTest
  fixtures :all
  
  def test_main_page
    get "/"
    assert_response :success
    assert_template "index"
  end
  def test_redirect_to_search_page
    post "/", {:query => "of"}
    assert_response :success
    assert_template "index"
  end 
end
