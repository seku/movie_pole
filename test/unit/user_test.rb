require '../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  context "relationships" do
    setup do
      @user = users(:first_user)
    end
    should_have_many :alerts

  end
end
