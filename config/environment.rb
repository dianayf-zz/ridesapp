require 'dotenv'
require 'sinatra'
require 'sequel'


configure :development do
  set :database, 'postgres:database.db'
end

configure :test do
  set :database, 'postgres:database.db'
end

if ENV['RACK_ENV'] == 'test'
    Dotenv.load('.env.test')
else
    Dotenv.load
end
