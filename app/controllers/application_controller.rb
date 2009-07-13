# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging :password, :password_confirmation

  include Helpers

  protect_from_forgery

  before_filter :set_locale, :set_defaults
  
  def set_defaults
    @count = %w{1 3 5 10}
    @rating = %w{1.0 5.0 6.0 7.0 8.0 9.0}
    @sort_by = ["release_date", "title", "rating"].map {|sort| [I18n.translate("sort.#{sort}"), sort] }
    @sort_mode = {:release_date => "desc", :rating => "desc", :title => "asc"}
  end
  
  def set_locale
    @locale = cookies[:locale] || "en"
    I18n.locale = @locale
  end

  def per_page #pagination number
    10
  end  


end
