class HomeController < ApplicationController
  
  def show
    redirect_to(admin_path)
  end
  
end
