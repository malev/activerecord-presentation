namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [User, Post].each(&:delete_all)

    User.populate 1000 do |user|
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.email = Faker::Internet.email
      puts user.first_name, user.last_name
      Post.populate 5..20 do |post|
        post.title = Populator.words(1..3).titleize
        post.body = Populator.sentences(2..10)
        post.state = %w(published draft searchable unsearchable).rand
        post.user_id = user.id
        puts post.title
      end
    end
  end
end

