class PhotosController < ApplicationController
 	def destroy
		@user = User.find(params[:user_id])
		@user.photo = nil
		@user.save
		redirect_to edit_account_url
	end 
end
