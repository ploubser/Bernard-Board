# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_LayoutTool_session',
  :secret      => 'cc8f79bedef678b8449923f90511c0ebe14bff7010803a22ac6f8a0b0ce1c1685aa0b92ba8ef69fca93bc843f7eeb4a2ae768a3a2a7d195f5d12dccff6c7a78a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
