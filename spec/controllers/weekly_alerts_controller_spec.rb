require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe WeeklyAlertsController do
  fixtures :users, :alerts
  
  before do  
    @current_user = users(:first)  
    controller.stub!(:current_user).and_return(@current_user)  
    session[:user_id] = @current_user.id  
    @weekly_alert = alerts(:one)
    @current_user.stub!(:weekly_alert).and_return(@weekly_alert)
  end  
  
  it "with xhr should be successful" do
    xhr :post, :create, :weekly_alert => @weekly_alert
    response.should be_success
  end

end

