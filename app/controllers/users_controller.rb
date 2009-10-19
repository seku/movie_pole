class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.all
    @current_user = current_user
  end
  
  def new
    if current_user 
      head :unprocessible_entity
    else
      @user = User.new
      render :layout => false if request.xhr? 
    end
  end

  def create
    @user = User.new(
    :login => params[:user][:login],
    #:password => params[:user][:email],
    #:password_confirmation => params[:user][:email],
    :email => params[:user][:email],
    :language => "en")
    if @user.save
      flash[:notice] = t('user.account_register')
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = @current_user
    @weekly_alert = current_user.weekly_alerts.new
    @followers = current_user.followers
    @followed_users = current_user.followed_users
    @desired_movies = desired_movies
  end

  def desired_movies
    @desired_movies = []
    User.find(params[:id]).desired_movies.each do |m|
      @movie = Movie.find(m.id)
      @desired_movies << {:movie_title => @movie.title, :movie_poster => @movie.poster, :movie_id => @movie.id}
    end
    @desired_movies_size = @desired_movies.size
    @desired_movies = @desired_movies.paginate :page => params[:page], :per_page => 10
    if request.xhr?
      render :json => @desired_movies
    else
      [@desired_movies, @desired_movies_size]
    end
  end


  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = t('user.account_update')
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    #@user.alerts.destroy_all # achived by seting ",:dependent => :destroy" to has_many :alerts in User model, this automatically destroy user's alerts when user is deleted.
    @user.destroy
    redirect_to genres_path
  end 
  
  def set_subtitles_language
    current_user.update_attributes(:language => params[:language])
    current_user.save
    render :nothing => true 
  end 

end
