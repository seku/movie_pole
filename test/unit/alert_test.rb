require '../test_helper'

class AlertTest < ActiveSupport::TestCase

  
  context "relationships" do
  
    should_belong_to :user

  end
end
