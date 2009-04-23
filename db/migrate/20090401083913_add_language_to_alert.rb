class AddLanguageToAlert < ActiveRecord::Migration
  def self.up
    add_column :alerts, :language, :string
  end

  def self.down
    remove_column :alerts, :language
  end
end
