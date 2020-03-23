require 'sinatra/base'
require 'sinatra'
require 'sequel'

class DriversController < ApplicationController

  post '/' do
    "creanding"
  end

  put '/' do
    "updating"
  end

  get '/:id' do
    t = Driver.where(id: params[:id])
    {message: "driver detail shown sucessfully", code: 0, data: t}.to_json
  end
end
