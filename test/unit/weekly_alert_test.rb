require '../test_helper'

class WeeklyAlertTest < ActiveSupport::TestCase
  fixtures :alerts, :users
  
  context "relationships" do
    setup do
      @weekly = alerts(:first)
    end
    
    should_belong_to :user
    should "have equal weekly alerts" do
      assert_equal 6.0, @weekly.rating 
      assert_equal 3, @weekly.genre_id 
      assert_equal "WeeklyAlert", @weekly.type 
    end  
    should_validate_uniqueness_of :genre_id
    
    should "have saved the alert" do
      assert_save WeeklyAlert.new(:genre_id => 2, :rating => 5.0)
    end
  end
  
  context "before_create" do
    setup do
      @user = users(:first_user)
    end
    should "delete all another alerts" do
      assert_save @user.weekly_alerts.new(:genre_id => 2, :rating => 4.0)
      assert_save @user.weekly_alerts.new(:genre_id => 4, :rating => 4.0)
      assert_equal 2, @user.weekly_alerts.size
      assert_save @user.weekly_alerts.new(:genre_id => 8, :rating => 4.0)
      @user.weekly_alerts.create!(:genre_id => 1, :rating => 4.0)
      assert_equal 1, @user.weekly_alerts.count, "It should be 1"
      
    end
  end
end
