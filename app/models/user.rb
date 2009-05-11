class User < ActiveRecord::Base
  is_gravtastic
  acts_as_authentic
  acts_as_authentic do |c|
    c.perishable_token_valid_for = 10.minutes
  end
  validates_presence_of :login, :email
	validates_uniqueness_of :login, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'email must be valid'
  has_many :alerts
  has_many :weekly_alerts
  has_many :desirable_alerts
  has_many :movies, :through => :desirable_alerts
  
  def deliver_login_link!
    reset_perishable_token!
    LoginLink.deliver_login_link(self)
  end



end
