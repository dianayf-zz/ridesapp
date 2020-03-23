require 'sinatra/base'
require 'sequel'

class RidesApp < Sinatra::Application
  get "/" do
    "hello world"
  end
end
