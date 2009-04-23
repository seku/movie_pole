class Alert < ActiveRecord::Base
  include Helpers
  belongs_to :user
  has_and_belongs_to_many :movies
  serialize :genre_id
  validates_uniqueness_of :genre_id
  before_create :remove_alerts_if_all
  before_update :remove_alerts_if_all_edit
  
  protected 
    
  def remove_alerts_if_all
    current_user.alerts.destroy_all if (genre_id == "1")      
  end
  
  #if all choosen, removes all alerts except updated one
  def remove_alerts_if_all_edit 
    Alert.destroy_all(["id != ? AND user_id = ?" , id, 1]) if (genre_id == "1")  
  end
end
