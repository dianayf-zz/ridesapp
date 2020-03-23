namespace :db do
  DB = Sequel.connect(
        adapter: :postgres,
        database: ENV["POSTGRES_DB"],
        host: ENV["POSTGRES_HOST"],
        user: ENV["POSTGRES_USER"],
        password: ENV["POSTGRES_PASSWORD"]
      )

  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel::Migrator.run(DB, "db/migrations", target: version)
  end

  desc "populate development database"
  Dir.glob('./models/*.rb').each { |file| require file } task :seed do
    Sequel.extension :seed 
    [ENV['RACK_ENV']].each do |dataset|
      Sequel::Seeder.apply(DB, "db/seeds/")
    end
  end
end
