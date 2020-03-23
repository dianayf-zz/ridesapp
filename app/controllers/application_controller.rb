require 'dotenv'
require 'sinatra'

class ApplicationController < Sinatra::Base
  configure do
    set :views, "./views"
    set :public_dir, "public"
  end

  not_found do
    title 'Not Found!'
    erb :not_found
  end
end
