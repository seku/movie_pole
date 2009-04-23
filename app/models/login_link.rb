class LoginLink < ActionMailer::Base
  
  def login_link(user)
    subject       "Password Reset Instructions"
    from          "movie_pole"
    recipients    user.email
    sent_on       Time.now
    body          :login_link => new_user_session_url(:token => user.perishable_token)
  end
 


end
