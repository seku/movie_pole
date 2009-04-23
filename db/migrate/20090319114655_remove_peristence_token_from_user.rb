class RemovePeristenceTokenFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :peristence_token
  end

  def self.down
    add_column :users, :peristence_token, :string
  end
end
