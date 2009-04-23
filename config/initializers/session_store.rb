# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_2_3_2_session',
  :secret      => 'e481875d8207ad4a2c3e1abc39b7aa2671f78f638ea1e36c8789b5bc1572523f828870dcef63fa21c249753799095e2da5cf6d10f5996922a1f87b6a80f7de3a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
