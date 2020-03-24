namespace :db do
  DB = Sequel.connect(
        adapter: :postgres,
        database: ENV["POSTGRES_DB"],
        host: ENV["POSTGRES_HOST"],
        user: ENV["POSTGRES_USER"],
        password: ENV["POSTGRES_PASSWORD"]
      )

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
  end

  desc "populate development database"
  Dir.glob('./models/*.rb').each { |file| require file }
  task :seed do
    Sequel.extension :seed 
    [ENV['RACK_ENV']].each do |dataset|
      Sequel::Seeder.apply(DB, "db/seeds/")
    end
  end
end
