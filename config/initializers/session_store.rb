# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_youmustdo_session',
  :secret      => '90780280059cf8d5871831af3321ddf35d65d71bcb81b6c0d193c008ec8aaa9bb3140b6db6bcfd8c67834652906916b3b2c2d70af2e8a981af91456331c78541'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
