class DesirablesController < ApplicationController
  
  def show
    @user_movie = current_user.user_movies.find_by_movie_id(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id]).title
    @user_movie = UserMovie.new(
      :user_id => current_user.id,
      :movie_id => params[:id]
    )    
    if request.xhr?
      if @user_movie.save
        render :json => { :flash => "#{@movie} #{t("user.movies_list_add")}" }.to_json
      else
        render :json => { :flash => t("user.movies_list_exist") }.to_json
      end
    else
      if @user_movie.save
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
      @user_movie = current_user.user_movies.find_by_movie_id(params[:id])
      @user_movie.destroy
      head :ok 
    else
      @user_movie = current_user.user_movies.find(params[:id])
      @user_movie.destroy      
      redirect_to(user_path(current_user)) 
    end
  end
end
