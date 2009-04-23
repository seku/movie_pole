require '../test_helper'

class AlertTest < ActiveSupport::TestCase
  fixtures :alerts
  
  context "relationships" do
    setup do
      @alert = alerts(:first)
    end
    
    should_belong_to :user
    should_have_and_belong_to_many :movies
    should_validate_uniqueness_of :genre_id
          
  end
end
