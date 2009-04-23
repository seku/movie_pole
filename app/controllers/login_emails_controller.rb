class LoginEmailsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit]
  
  def show
    @user_session = UserSession.create!(
    :login => params[:login],
    :password => "sseku@o2.pl")

    if @user_session.save
      flash[:notice] = "Login successful! #{@user.login}"
      redirect_back_or_default genres_path
    else
      render :action => :new
    end
  end

  def edit
    redirect_to :action => :update, :login => @user.login, :password => @user.email

  end

  def update
    flash[:notice] = "password: #{params[:password]}"
    redirect_to gneres_path
=begin
    @user_session = UserSession.create!(
    :login => @user.login,
    :password => params[:password])

    if @user_session.save
      flash[:notice] = "Login successful! #{@user.login}"
      redirect_back_or_default genres_path
    else
      render :action => :new
    end

    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated"
      redirect_to account_path
    else
      render :action => :edit
    end
=end
  end

  def new
    #render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_login_link!
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +
        "Please check your email."
      redirect_to genres_path
    else
      flash[:notice] = "No user was found with that email address"
      render :action => :new
    end
  end
  
  protected
  
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:notice] = "We're sorry, but we could not locate your account. " +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to genres_path
      end
    end


end
