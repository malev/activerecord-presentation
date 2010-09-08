!SLIDE 
# Advance ActiveRecord #
## Marcos Vanetta
## Aycron
### 2010

!SLIDE bullets incremental transition=fade smaller
# Agenda #

* Validations and how to skip them
* Order
* Changed?
* conditional search
* Named_scope
* Default_scope
* Include & Join (differences)

!SLIDE transition=fade
# Validations #
* Validations are used to ensure that only valid data is saved into your database.
* Use: validate_XXX_of :field, *attr_names
* Attr: message, allow_nil, allow_blank, with, on, if unless

!SLIDE transition=fade code
	@@@ ruby
	class User < ActiveRecord::Base
	  validates_presence_of :first_name
	  validates_format_of :email,
		                  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
		                  :on => :create,
		                  :message => "email must be valid"
	  validates_uniqueness_of :email
	end

!SLIDE transition=fade
# Skip Validations #
fsdf

!SLIDE transition=fade commandline incremental
## Order ##
	$ u = User.all :order => :email
	SELECT * FROM `users` ORDER BY email
	
	$ u = User.all :order => ["first_name ASC, email DESC"]
	SELECT * FROM `users` ORDER BY first_name ASC, email DESC

!SLIDE transition=fade code
# Default order #
    @@@ ruby
    class Post < ActiveRecord::Base
  	  default_scope :order => 'title'
  	end

	$ >> p = Post.all
	SELECT * FROM `posts` ORDER BY title

	>> p = Post.all :with_exclusive_scope, :limit => 10
    SELECT * FROM `posts` ORDER BY title LIMIT 10

!SLIDE transition=fade commandline incremental
## changed? ##
	$ u = User.first
	  User Load (0.2ms)   SELECT * FROM `users` LIMIT 1
	+----+------------+-----------+--------------------------+-------+-------------+
	| id | first_name | last_name | email                    | admin | posts_count |
	+----+------------+-----------+--------------------------+-------+-------------+
	| 2  | Elisa      | Huel      | shyanne.kuhlman@lindg... | false | 20          |
	+----+------------+-----------+--------------------------+-------+-------------+
	1 row in set
	$ >> u.changed?
	=> false
	$ >> u.first_name = "Anita"
	=> "Anita"
	$ >> u.changed?
	=> true
	$ >> u.changed
	=> ["first_name"]
	$ >> u.last_name = "Laporte"
	=> "Laporte"
	$ >> u.changes
	=> {"last_name"=>["Huel", "Laporte"], "first_name"=>["Elisa", "Anita"]}
	[Development]>> 

!SLIDE transition=fade commandline incremental
# conditional search #
## Mediante un Array ##
	$ >> u = User.all :conditions => ["first_name = ?", "Marcos"]
	SELECT * FROM `users` WHERE (first_name = 'Marcos') 

	$ >> u = User.all :conditions => ["first_name = ?", nil]
	SELECT * FROM `users` WHERE (first_name = NULL) 

!SLIDE transition=fade commandline incremental small
# conditional search #
## Mediante un Hash ##
	$ >> u = User.all :conditions => {:first_name => "Marcos"}
	SELECT * FROM `users` WHERE (`users`.`first_name` = 'Marcos') 

	$ >> u = User.all :conditions => {:first_name => nil}
	SELECT * FROM `users` WHERE (`users`.`first_name` IS NULL) 

	$ >> u = User.all :conditions => {:first_name => ["Ana", "Lucas"]}
	SELECT * FROM `users` WHERE (`users`.`first_name` IN ('Ana','Lucas'))
	
	$>> u = User.all :conditions => {:first_name => "A", :email => nil}
    SELECT * FROM `users` WHERE (`users`.`email` IS NULL AND `users`.`first_name` = 'A')

!SLIDE transition=fade code smaller
# Named_scope - 1 #
	@@@ ruby
	class Post < ActiveRecord::Base
	
   	  named_scope :three, :conditions => {:user_id => 3}

	  named_scope :searchable,
	      :conditions => {:state => 'searchable'}

	  named_scope :bad_recent, 
		  :conditions => {:created_at => 2.weeks.ago}
	
	  named_scope :recent,
	      lambda { {:conditions => ["created_at > ?", 2.weeks.ago] } }
	end

!SLIDE transition=fade code smaller
# Named_scope - 2 #
	@@@ ruby
	class Post < ActiveRecord::Base

	  named_scope :our_recent,
	      lambda{ |time| {:conditions => ["created_at > ?", time] } }
	
	  named_scope :our_recent_two,
	      lambda { |*args| {:conditions =>
	               ["created_at > ?", (args.first || 2.weeks.ago)]} }

	end

!SLIDE transition=fade
# INCLUDE vs JOIN #

!SLIDE transition=fade
## References 
1. http://guides.rubyonrails.org/active_record_validations_callbacks.html
2. http://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_format_of
