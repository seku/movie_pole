# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :set_locale, :set_defaults
  
  def set_defaults
    @rating = %w{1.0 5.0 6.0 7.0 8.0 9.0}
    @sort_by = Sort.all.map{ |s| [I18n.translate("sort.#{s.name}"), s.name] } 
  end
  
  def set_locale
    I18n.locale = cookies[:locale] || :en
  end

  def pn #pagination number
    10
  end
end
