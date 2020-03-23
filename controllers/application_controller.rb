require 'sinatra/base'

class ApplicationController < Sinatra::Base

  before do
    content_type :json
  end

  not_found do
    title 'Not Found!'
    erb :not_found
  end
end
