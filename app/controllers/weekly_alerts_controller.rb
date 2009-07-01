class WeeklyAlertsController < ApplicationController
  
  def show
    @weekly_alert = current_user.weekly_alerts.find(params[:id])
  end
  
  def new
    @weekly_alert = current_user.weekly_alerts.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @weekly_alert = current_user.weekly_alerts.new(params[:weekly_alert])
    @user = current_user
    if request.xhr?    
      if @weekly_alert.save
        render_json
      else
        head :unprocessable_entity
      end
    else
      if @weekly_alert.save
        flash[:notice] = t("user.alert_flash_create")
        redirect_to user_path(current_user)
      else
        flash[:notice] = t("user.alert_flash_genre")
        render :new
      end
    end
  end
  
  def edit
    @weekly_alert = current_user.weekly_alerts.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @user = current_user
    @weekly_alert = current_user.weekly_alerts.find(params[:id])
    respond_to do |format|
      format.html {
        if @weekly_alert.update_attributes(params[:weekly_alert])
          redirect_to user_path(current_user)
        else
          flash[:notice] = t("user.alert_flash_genre")
          render :edit
        end
      }
      format.js {  
        if @weekly_alert.update_attributes(params[:weekly_alert])
          render_json
        else  
          head :unprocessable_entity
        end
      }
    end      
  end
  
  def destroy
    @weekly_alert = current_user.weekly_alerts.find(params[:id])
    @weekly_alert.destroy
    respond_to do |format|
      format.html { redirect_to(user_path(current_user)) }
      format.js  { head :ok }
    end
  end
  
  def render_json
    render :json => {
      :alert => {
        :rating => @weekly_alert.rating, 
        :name => self.class.helpers.alert_genre(@weekly_alert.genre_id), 
        :genre_name => Genre.find(@weekly_alert.genre_id).name, 
        :id => @weekly_alert.id },
      :user => @user.id
      }
  end
end



