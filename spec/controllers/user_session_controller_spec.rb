require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
 
  it "should login successfull redirect" do
    @user = mock_model(User)
    User.stub!(:find_using_perishable_token).and_return(@user)
    UserSession.stub!(:create).with(@user).and_return(true)
    get :new
    flash[:notice].should == "Login successfull"
    response.should redirect_to(genres_path)
  end
  
  it "should destroy session" do
    @current_user_session = mock_model(UserSession)
    UserSession.stub!(:find).and_return(@current_user_session)
    @current_user_session.stub!(:destroy).and_return(true)
    post :destroy
    flash[:notice].should == "Logout successfull"
  end
end
