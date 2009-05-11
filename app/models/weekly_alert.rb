class WeeklyAlert < Alert
  validates_uniqueness_of :genre_id
  before_create :remove_weekly_alerts_if_genre_all
  before_update :remove_weekly_alerts_if_genre_all_edit 
  
  protected 
    
  def remove_weekly_alerts_if_genre_all
    user.weekly_alerts.destroy_all if Genre.find(genre_id).name == "all" 
  end
  
  #if all choosen, removes all alerts except updated one
  def remove_weekly_alerts_if_genre_all_edit 
    WeeklyAlert.destroy_all(["id != ? AND user_id = ?" , id, user_id]) if Genre.find(genre_id).name == "all"
  end
end
