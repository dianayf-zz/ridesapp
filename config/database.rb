require 'sequel'
require 'dotenv'

DB = Sequel.connect(ENV["DATABASE_URL"])
