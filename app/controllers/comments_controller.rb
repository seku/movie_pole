class CommentsController < ApplicationController
  def index
  end
  
  def sending
    CommentMailer.deliver_comment_email(current_user, params[:comment])
    flash[:notice] = "Thank you for your comment"
    redirect_to account_path
  
  end
end
