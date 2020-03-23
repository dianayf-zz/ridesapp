require 'sinatra'
require 'sequel'

configure :development do
  set :database, 'postgres:database.db'
end
