require 'sequel'
require "sequel/extensions/seed"


DB = Sequel.connect(
  adapter: :postgres,
  database: ENV["POSTGRES_DB"],
  host: ENV["POSTGRES_HOST"],
  user: ENV["POSTGRES_USER"],
  password: ENV["POSTGRES_PASSWORD"]
 )

Dir.glob('./models/*.rb').each { |file| require file }

# loads the extension
Sequel.extension :seed 
 
Sequel::Seed.setup :development

# seeds the database
Sequel::Seeder.apply(DB, "db/seeds/")
