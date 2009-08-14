class User < ActiveRecord::Base

  #attr_accessor :antispam_security_token
  is_gravtastic
  acts_as_authentic do |c|
    c.perishable_token_valid_for = 10.minutes
    c.validate_password_field = false
    #c.require_password_confirmation = false
  end
  validates_presence_of :login, :email
	validates_uniqueness_of :login, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'email must be valid'
  has_many :alerts, :dependent => :destroy
  has_many :weekly_alerts
  has_many :desirable_alerts
  has_many :desired_movies, :through => :desirable_alerts, :source => :movie, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :voted_movies, :through => :votes, :source => :movie, :dependent => :destroy
  
  
  has_many :followings_as_user, :class_name => "Following", :foreign_key => "user_id", :dependent => :destroy
  has_many :followings_as_follower, :class_name => "Following", :foreign_key => "follower_id", :dependent => :destroy
  has_many :followers, :through => :followings_as_user
  has_many :followed_users, :through => :followings_as_follower, :source => :user
  
  def deliver_login_link!
    reset_perishable_token!
    LoginLink.deliver_login_link(self)
  end
  
  #validate :must_be_human
  
  #def must_be_human
  #  return unless antispam_security_token
  #  errors.add(:antispam_security_token, "you are fuckin spammer!!")
  #end
  
end
