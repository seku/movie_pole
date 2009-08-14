class VotesController < ApplicationController
 
  def create
    @movie = Movie.find(params[:id])
    @vote = Vote.new(
      :user_id => current_user.id,
      :movie_id => params[:id],
      :user_rating => params[:user_rating].to_i
    )    
    if request.xhr?
      if @vote.save
        render :json => { :flash => "#{t('user.vote.create')}#{@vote.user_rating}", :user_rating => params[:user_rating], :average_rating => @movie.average_rating }
      else
        redirect_to genres_path
      end
    end
  end
  
  def update
    @movie = Movie.find(params[:id])
    @vote = Vote.find_by_movie_id_and_user_id(params[:id], current_user.id)
    @vote.update_attributes(:user_rating => params[:user_rating].to_i)    
    if request.xhr?
      if @vote.save
        render :json => { :flash => "#{t('user.vote.update')}#{@vote.user_rating}", :user_rating => params[:user_rating], :average_rating => @movie.average_rating }
      else
        render :json => { :flash => "Inpredictible error" }
      end
    else
      if @vote.save
        flash[:notice] = { :flash => "#{t('user.vote.update')}#{@vote.user_rating}", :user_rating => params[:user_rating] }
        redirect_to genres_path
      else
        flash[:notice] = "Inpredictible error"
        redirect_to genres_path
      end
    end
  end
  
  def destroy
    if request.xhr?
      @movie = Movie.find(params[:id])
      @vote = current_user.votes.find_by_movie_id(params[:id])
      @vote.destroy
      render :json => { :flash => t('user.vote.delete'), :user_rating => 0, :average_rating => @movie.average_rating } 
    else
      @vote = current_user.votes.find(params[:id])
      @vote.destroy      
      redirect_to(user_path(current_user)) 
    end
  end

end
