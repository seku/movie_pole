class LoginEmailsController < ApplicationController
  before_filter :require_no_user
  
  def new
    render :layout => false if request.xhr?
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_login_link!
      flash[:notice] = t('user.login_link', :email => params[:email])
      redirect_to genres_path
    else
      flash[:notice] = t('user.no_user')
      render :action => :new
    end
  end
end
