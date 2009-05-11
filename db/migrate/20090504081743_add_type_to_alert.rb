class AddTypeToAlert < ActiveRecord::Migration
  def self.up
    add_column :alerts, :type, :string
  end

  def self.down
    remove_column :alerts, :type
  end
end
