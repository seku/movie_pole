require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe DesirableAlertsController do
  
  before do
    @user = mock_model(User)
    @desirable_alerts = mock_model(DesirableAlert)
    User.stub!(:find).and_return(@user)
    @user.stub(:desirable_alerts).and_return(@desirable_alerts)
    @desirable_alerts.stub!(:find).with("1").and_return(@desirable_alerts)
  end
  
  it "should receive alerts " do
    User.should_receive(:find).and_return(@user)
    @user.desirable_alerts.should_receive(:find).with("1").and_return(@desirable_alerts)
    get :show
  end
  
  it "action index should response with success" do 
    get :show 
    respond_with :success
  end

  it "with xhr should be successful" do
    xhr :get, :edit
    response.should be_success
  end

end

