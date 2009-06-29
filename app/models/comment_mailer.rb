class CommentMailer < ActionMailer::Base
  
  def comment_email(user, comments)
    subject       "Comment"
    from          "trix@trix.megiteam.pl"
    recipients    "sekupyna@gmail.com"
    sent_on       Time.now
    body          :comments => comments, :user => user
  end
end
