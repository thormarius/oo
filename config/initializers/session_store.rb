# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oo_session',
  :secret      => '66e06b6c192f1d2310aa173d85b673c8cc9bdbb085eea31ba8b562749250b797084e83ef92c2b852aff3ae537c71f420fe349939108c97664c8243aefdc5cee6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
