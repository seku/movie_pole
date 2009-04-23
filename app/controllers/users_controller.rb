class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.create!(
    :login => params[:user][:login],
    :password => params[:user][:email],
    :password_confirmation => params[:user][:email],
    :email => params[:user][:email],
    :language => "en")
    
    #@user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default genres_url
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
    @alert = current_user.alerts.new
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end



  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to genres_path
  end  

end
