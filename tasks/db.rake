namespace :db do
  DB = Sequel.connect(ENV["DATABASE_URL"])

  desc "current schema version"
  task :version do
    version = DB[:schema_migrations] ? DB[:schema_migrations].first[:version] : 0
    puts "Schema Version: #{version}"
  end

  desc "Run migrations"
  task :migrate do 
    Sequel.extension :migration
    Sequel::Migrator.run(DB,'db/migrations')
    Rake::Task['db:version'].execute
    Dir.glob('./models/*.rb').each { |file| require file }
  end

  desc "populate development database"
  task :seed do
    Sequel.extension :seed 
    [ENV['RACK_ENV']].each do |dataset|
      Dir.glob('./models/*.rb').each { |file| require file }
      Sequel::Seeder.apply(DB, "db/seeds/")
    end
  end
end
