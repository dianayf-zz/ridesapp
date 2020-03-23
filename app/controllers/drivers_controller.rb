require 'sequel'
class DriversController < ApplicationController

  post '/' do
    "creanding"
  end

  put '/' do
    "updating"
  end

  get '/:id' do
    t = Driver.where(id: params[:id]).first.to_json
    puts "#{t}lalalalalalal * 20"
    t
  end
end
