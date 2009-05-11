# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation
  #helper_method :current_user_session, :current_user
  include Helpers
  # See ActionController::RequestForgeryProtection for details
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :set_locale, :set_defaults
  
  def set_defaults
    @count = %w{1 3 5 10}
    @rating = %w{1.0 5.0 6.0 7.0 8.0 9.0}
    @sort_by = ["release_date", "title", "rating"].map {|sort| [I18n.translate("sort.#{sort}"), sort] }
    @sort_mode = {:release_date => "desc", :rating => "desc", :title => "asc"}
  end
  
  def set_locale
    I18n.locale = cookies[:locale] || :en
  end

  def per_page #pagination number
    10
  end

    


end
