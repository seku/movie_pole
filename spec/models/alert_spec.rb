require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Alert do
  
  it { should belong_to :user }
  it "should create alert" do
    Alert.create!(:rating => 6.0, :genre_id => 5, :type => "WeeklyAlert")
  end
end
