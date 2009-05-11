require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe DesirableAlert do
  fixtures :alerts
  
  it "should have equal values"  do
    @desirable = alerts(:two)
    assert_equal 1, @desirable.user_id 
    assert_equal 88, @desirable.movie_id 
    assert_equal "DesirableAlert", @desirable.type 
  end  
  it "should validate properly" do
    should validate_uniqueness_of(:movie_id).scoped_to(:user_id)
  end

  it { should belong_to :user }
  it { should belong_to :movie }
  
end
