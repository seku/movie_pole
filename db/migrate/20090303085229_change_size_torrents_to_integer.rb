class ChangeSizeTorrentsToInteger < ActiveRecord::Migration
  def self.up
  	change_column(:torrents, :size, :integer)
  end

  def self.down
  	change_column(:torrents, :size, :string)
  end
end
