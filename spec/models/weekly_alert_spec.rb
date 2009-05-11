require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe WeeklyAlert do

  fixtures :users, :alerts, :genres #just if fixtures approach
  before(:each) do 
    @user = users(:first) #fixtures approach
    @weekly_alert = alerts(:one)
    
    #just create the object in database
    #@user = User.create!(:login => "robert", :email => "sseku@o2.pl", :password => "tata", :password_confirmation => "tata")   
  
  end
  it "should belong to user" do
    should belong_to :user
  end
  
  it "should have equal values" do
    @weekly_alert.rating.should == 6.0
    @weekly_alert.genre_id.should == 86
  end
  
  it "should have something" do
    @user.weekly_alerts.build(:genre_id => 5, :rating => 5.0)
    @user.weekly_alerts.build(:genre_id => 4, :rating => 5.0)
    @user.weekly_alerts.build(:genre_id => 85, :rating => 5.0)
    @user.weekly_alerts.size.should == 2
  
  end
  it "should 4 times exist in user alerts" do
    users(:first).weekly_alerts.size.should == 4
  end
  it "should create relationship" do
    @user.weekly_alerts << @weekly_alert
    @user.weekly_alerts.size.should == 1 
  end
  it "should stub" do
    @user.weekly_alerts.stub(:create).and_return(@weekly_alert)
    @user.weekly_alerts.size.should == 1 
  end
  
  it "should create alerts and destroy them if genre == all" do
    @first = @user.weekly_alerts.create!(:genre_id => 2, :rating => 5.0)
    #@first.save.should be_true
    @user.weekly_alerts.all.count.should eql(1)
    @user.weekly_alerts.create!(:genre_id => 3, :rating => 5.0)
    @user.weekly_alerts.all.count.should eql(2)
    @user.weekly_alerts.create!(:genre_id => 1, :rating => 5.0)
    @user.weekly_alerts.all.count.should eql(1)    
  end

  it "should create alerts and destroy them if alert is edited with genre_id == 1" do
    @first = @user.weekly_alerts.new(:genre_id => 2, :rating => 5.0)
    @first.save.should be_true
    @user.weekly_alerts.all.count.should eql(1)
    @user.weekly_alerts.create!(:genre_id => 3, :rating => 5.0)
    @user.weekly_alerts.all.count.should eql(2)
    @user.weekly_alerts.create!(:genre_id => 4, :rating => 5.0)
    @user.weekly_alerts.all.count.should eql(3)  
    @user.weekly_alerts.first.update_attributes(:genre_id => 1, :rating => 3.0)
    @user.weekly_alerts.all.count.should eql(1)  
  end

end
