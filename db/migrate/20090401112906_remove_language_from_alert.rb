class RemoveLanguageFromAlert < ActiveRecord::Migration
  def self.up
    remove_column :alerts, :language
  end

  def self.down
    add_column :alerts, :language, :string
  end
end
