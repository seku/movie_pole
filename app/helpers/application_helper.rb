# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def languages
    languages = Dir.entries("#{RAILS_ROOT}/config/locales/").map do |l| 
      lang = l.match(/(\w+)(.yml)/).to_s
      lang.chomp(".yml")
    end
    languages.delete("")
    languages
  end

end
