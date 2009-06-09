# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require File.dirname(__FILE__) + '/../backends/imdb/lib/imdb'
require File.dirname(__FILE__) +'/../backends/mininova/lib/mininova'
require "smtp_tls"

Rails::Initializer.run do |config|
  config.gem "haml"
  config.gem 'mislav-will_paginate', :version => '~> 2.2.3', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem "thoughtbot-shoulda", :lib => false, :source => "http://gems.github.com"
  config.gem "authlogic"
  config.action_mailer.delivery_method = :smtp
  config.gem 'gravtastic'
  config.gem "rspec", :lib => false, :version => ">= 1.2.6"
  config.gem "rspec-rails", :lib => false, :version => ">= 1.2.6"

  config.time_zone = 'UTC'
  #config.gem('freelancing-god-thinking-sphinx', :lib => 'thinking_sphinx', :version => '1.1.20')


end
