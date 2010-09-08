# == Schema Information
# Schema version: 20100905214303
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  body       :text
#  state      :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  default_scope :order => 'title'

  named_scope :three, :conditions => {:user_id => 3}
  named_scope :searchable,
              :conditions => {:state => 'searchable'}
  named_scope :recent,
              lambda { {:conditions => ["created_at > ?", 2.weeks.ago] } }
  named_scope :our_recent,
              lambda{ |time| {:conditions => ["created_at > ?", time] } }
  named_scope :our_recent_two,
              lambda { |*args| {:conditions =>
                       ["created_at > ?", (args.first || 2.weeks.ago)]} }
end

