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
  has_many :alerts
  has_many :weekly_alerts
  has_many :desirable_alerts
  has_many :movies, :through => :desirable_alerts
  
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
