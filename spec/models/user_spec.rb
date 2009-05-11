require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe User do
  fixtures :users

  before(:each) do
    @user = users(:first)
  end
  
  it " should have correct language" do
    @user.language.should == "en" 
  end
  
  it "should have correct login" do
    @user.login.should == "robert" 
  end
  
  it "should have correct email" do
    @user.email.should == "sseku@o2.pl" 
  end

  it "should" do should have_many :alerts end
  it "should" do should have_many :desirable_alerts end  
  it "should" do should have_many :weekly_alerts end
  it "should" do should have_many(:movies).through(:desirable_alerts) end
  it "should" do should validate_presence_of :login end
  it "should" do should validate_presence_of :email end
  it "should" do should validate_uniqueness_of :login end
  it "should" do should validate_uniqueness_of :email end
  
end
