class LoginEmailsController < ApplicationController
  #before_filter :check_user 
  
  def new
    if current_user
      head :unprocessable_entity
    else
      render :layout => false if request.xhr?
    end
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_login_link!
      flash[:notice] = t('user.login_link', :email => params[:email])
      redirect_to genres_path
    else
      flash[:notice] = t('user.no_user')
      redirect_to genres_path
    end
  end
  
  private 
  
  def check_user
    if current_user
      redirect_to user_path(current_user)
    end
  end
    
end
