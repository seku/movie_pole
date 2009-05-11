class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :show]
  before_filter :require_user, :only => :destroy
  #before_filter :load_user_using_perishable_token, :only => [:new]
  

  def new
    @user_session = UserSession.new
  end
  
  def show
    @user_session = current_user_session
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
       flash[:notice] = t("user.login_success")
       redirect_back_or_default genres_path
    else
      flash[:notice] = t("user.login_failed")
      redirect_back_or_default genres_path
    end
  end
 
  def destroy
    current_user_session.destroy
    flash[:notice] = t("user.logout_success")
    redirect_back_or_default genres_path
  end
  protected
  
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:token])
      unless @user
        flash[:notice] = "We're sorry, but we could not locate your account. " +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to genres_path
      end
    end


end
