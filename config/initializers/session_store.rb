# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_activeR_session',
  :secret      => '87d8d65bf5b39f82ffe56dd02f5b928477957987e3fc728fb44800c9ccc009d5a7ae1f457787f1dd3accc8bc485ac65dc538f7d402817132091671e1fdf60af8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
