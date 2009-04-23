class AlertsController < ApplicationController
  
  def show
    @alert = current_user.alerts.find(params[:id])
  end
  
  def new
    @alert = current_user.alerts.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @alert = current_user.alerts.new(params[:alert])
    @user = current_user
    if request.xhr?    
      if @alert.save
        render :json => {
          :alert => {
            :rating => @alert.rating, 
            :name => self.class.helpers.alert_genre(@alert.genre_id), 
            :genre_id => @alert.genre_id, 
            :id => @alert.id },
          :user => @user.id
        }.to_json
      else
        head :unprocessable_entity
      end
    else
      if @alert.save
        flash[:notice] = 'Alert was successfully created.'
        redirect_to user_path(current_user)
      else
        flash[:notice] = 'You have already choosen that genre'
        render :new
      end
    end
  end
  
  def edit
    @alert = current_user.alerts.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @user = current_user
    @alert = current_user.alerts.find(params[:id])
    respond_to do |format|
      format.html {
        if @alert.update_attributes(params[:alert])
          redirect_to user_path(current_user)
        else
          flash[:notice] = "You have already choosen that genere"
          render :edit
        end
      }
      format.js {  
        if @alert.update_attributes(params[:alert])
          render :json => {
            :alert => {
              :rating => @alert.rating, 
              :name => self.class.helpers.alert_genre(@alert.genre_id), 
              :genre_id => @alert.genre_id, 
              :id => @alert.id },
            :user => @user.id
          }.to_json
        else  
          head :unprocessable_entity
        end
      }
    end      
  end
  
  def destroy
    @alert = current_user.alerts.find(params[:id])
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to(user_path(current_user)) }
      format.js  { head :ok }
    end
  end

end
