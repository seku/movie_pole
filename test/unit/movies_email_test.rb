require '../test_helper'

class MoviesEmailTest < ActionMailer::TestCase
  def setup
    @user = User.new(:login => "Robert" , :email => "sseku@o2.pl" )
  end
  def test_movies_email
    response = MoviesEmail.create_movies_email(@user)
    assert_equal("Send list of movies" , response.subject)
    assert_equal("sseku@o2.pl" , response.to[0])
    assert_match(/drama/, response.body)
  end

end
