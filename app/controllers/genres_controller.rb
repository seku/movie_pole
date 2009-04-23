class GenresController < ApplicationController
	def index
	  @genres = Genre.all
	  respond_to do |format|  
      format.html # index.html.erb  
      format.js # index.js.erb  
    end  
	end
end
