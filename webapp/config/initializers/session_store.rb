# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => 'bindadmin_session',
  :secret      => '05859ab633be5a99240f4f3453f3eff3e5e61da8c9648a1aa16dd97cb7cd605893fda6eacaeec123a2c20b1338b513178b194b200ef71795c5db07cfa77625e5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store = :active_record_store
