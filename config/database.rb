require 'sequel'

DB = Sequel.connect(
  adapter: :postgres,
  database: ENV["POSTGRES_DB"],
  host: ENV["POSTGRES_HOST"],
  user: ENV["POSTGRES_USER"],
  password: ENV["POSTGRES_PASSWORD"]
 )
