require '../test_helper'

class DesirableAlertTest < ActiveSupport::TestCase
  fixtures :alerts
  
  context "relationships" do
    setup do
      @desirable = alerts(:two)
    end
    should "have desirable alerts" do
      assert_equal 1, @desirable.user_id 
      assert_equal 88, @desirable.movie_id 
      assert_equal "DesirableAlert", @desirable.type 
    end  
    should_validate_uniqueness_of :movie_id, :scoped_to => :user_id
    should_belong_to :movie
  end
end
