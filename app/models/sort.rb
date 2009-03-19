class Sort < ActiveRecord::Base
  validates_uniqueness_of :name
  
  def self.fetch_sorts
    ["release_date", "title", "rating"].each{ |sort| Sort.create!(:name => sort) }
  end
end
