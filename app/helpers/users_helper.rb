module UsersHelper
  def  alert_genre(id)
    I18n.translate("genres.#{Genre.find(id).name}")
  end
  
  def is_there_genre_all_choosen
    (Genre.find(@user.weekly_alerts.first.genre_id).name == "all") ? true : false
  end
  
end
