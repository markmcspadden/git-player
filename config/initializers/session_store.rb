# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_git-player_session',
  :secret      => '3819d1ffdce392626cb52c7e27d2e6b75a61d05a962034bbc99c9d07f631b67b9e9dd9e52809a706f04e0e8cde93beb709c8f44b8d894ab6dd34a272a5c710e0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
