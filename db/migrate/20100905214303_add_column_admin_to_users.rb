class AddColumnAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false, :null => false
    User.reset_column_information
    User.find(:all).each do |u|
      u.update_attribute :admin, false
    end
  end

  def self.down
    remove_column :users, :admin
  end
end

