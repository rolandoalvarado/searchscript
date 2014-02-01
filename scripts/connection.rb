# ------------------------------------------------------------------------------
# - Database Connection
# ------------------------------------------------------------------------------
require 'rails/all'
require 'active_record'
require 'mysql2' # or 'pg' or 'sqlite3'

if Rails.env.development?
  database_name = 'yelp_db_development' 
else
  database_name = 'yelp_db_production'
end

# Change the following to reflect your database settings
ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     'localhost',
  database: database_name,
  username: 'root',
  password: ''
)
#-------------------------------------------------------------------------------
