class CommentMailer < ActionMailer::Base
  
  def comment_email(user, comment)
    subject       "Comment"
    from          "trix@trix.megiteam.pl"
    recipients    "sekupyna@gmail.com"
    sent_on       Time.now
    body          :comment => comment, :user => user
  end
end
