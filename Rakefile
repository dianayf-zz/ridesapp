require './config/environment'

Dir["tasks/*.rake"].sort.each { |task| load task }

#sequel -m db/migrations/ postgres://postgres:postgres@localhost/rides_local

#Sequel.extension :seed 
#Sequel::Seed.setup :development

# seeds the database
#Sequel::Seeder.apply(DB, "db/seeds/")
