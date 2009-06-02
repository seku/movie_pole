require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")


describe MoviesEmail, "should have movies_email and it" do

  fixtures :users, :movies
  before do
    @user = users(:first)
    @movies = [movies(:first_movie), movies(:last_movie)]
    @email = MoviesEmail.create_movies_email(@user, @movies)
    
  end
  
  it "should respond with proper subject " do 
    @email.should have_subject("Send list of movies")
  end
  
  it "should be sent to  " do 
    @email.should deliver_to("sseku@o2.pl") 
  end
  
  it "should have title " do 
    @email.should have_body_text(/List of newest movies/)
  end
end

describe MoviesEmail, "should have desirable_email and it" do

  fixtures :users, :movies
  before do
    @user = users(:second)
    @movies = [movies(:first_movie), movies(:last_movie)]
    @email = MoviesEmail.create_desirable_email(@user, @movies)
  end
  
  it "should respond with proper subject " do 
    @email.should have_subject("Send list of movies")
  end
  
  it "should be sent to  " do 
    @email.should deliver_to("sekupyna@yahoo.com") 
  end
  
  it "should have title " do 
    @email.should have_body_text(/List of expected movies, which have now torrents/)
  end
end
