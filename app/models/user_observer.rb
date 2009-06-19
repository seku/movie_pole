class UserObserver < ActiveRecord::Observer
  #observe :user, ...  <- it should be add if the observer should observe not only User model 
  def after_create(user) # user here means User model 
    MoviesEmail.deliver_invitation_email(user)
  end
end
