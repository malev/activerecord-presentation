class AddCounterCacheToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :posts_count, :integer, :default => 0

    User.reset_column_information
    User.all.each { |user| User.update_counters user.id, :posts_count => user.posts.count }
  end

  def self.down
    remove_column :users, :posts_count
  end
end

