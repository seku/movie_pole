require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe AlertsEmailsController do
  fixtures :users, :alerts
  
  before do  
    @user = user(:first)
    @alert = alerts(:one)
  end  
  
  it "should be successful" do

  end

end

