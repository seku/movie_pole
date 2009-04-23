module UsersHelper
  def  alert_genre(id)
    I18n.translate("genres.#{Genre.find(id).name}")
  end
end
