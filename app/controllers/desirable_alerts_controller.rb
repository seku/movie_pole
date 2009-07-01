class DesirableAlertsController < ApplicationController
  
  def show
    @desirable_alert = current_user.desirable_alerts.find_by_movie_id(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id]).title
    @desirable_alert = DesirableAlert.new(
      :user_id => current_user.id,
      :movie_id => params[:id]
    )    
    if request.xhr?
      if @desirable_alert.save
        render :json => { :flash => "#{@movie} #{t("user.movies_list_add")}" }
      else
        render :json => { :flash => t("user.movies_list_exist") }
      end
    else
      if @desirable_alert.save
        flash[:notice] = "#{@movie} #{t("user.movies_list_add")}"
        redirect_to genres_path
      else
        flash[:notice] = t("user.movies_list_exist")
        redirect_to genres_path
      end
    end
  end
  
  def destroy
    if request.xhr?
      @desirable_alert = current_user.desirable_alerts.find_by_movie_id(params[:id])
      @desirable_alert.destroy
      head :ok 
    else
      @desirable_alert = current_user.desirable_alerts.find(params[:id])
      @desirable_alert.destroy      
      redirect_to(user_path(current_user)) 
    end
  end
end
