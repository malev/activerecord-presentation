# == Schema Information
# Schema version: 20100905214303
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  admin      :boolean(1)      not null
#

class User < ActiveRecord::Base
  validates_presence_of :first_name
  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                      :on => :create,
                      :message => "email must be valid"
  validates_uniqueness_of :email

  has_many :posts
end

