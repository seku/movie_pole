require '../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  context "relationships" do
    setup do
      @user = users(:first_user)
    end
    should_have_many :alerts
    should_have_many :desirable_alerts  
    should_have_many :weekly_alerts
    should_have_many :movies, :through => :desirable_alerts
    should_validate_presence_of :login, :email
    should_validate_uniqueness_of :login, :email
    should "have correct language" do
      assert_equal "en", @user.language
    end
    should "have correct login" do
      assert_equal "robert", @user.login
    end
    should "have correct email" do
      assert_equal "sseku@o2.pl", @user.email
    end
  end
end
