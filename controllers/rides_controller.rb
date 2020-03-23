require 'sequel'

class RidesController < ApplicationController

  post '/' do
    "creanding"
  end

  put '/' do
    "updating"
  end

  get '/:id' do
    "detalling"
  end

  post '/ride/' do
    latitude = params[:latitude]
    longitude = params[:longitude]
    driver = DriverAssigner.search(latitude, longitude)
    Ride.new(
        status: "assigned",
        driver_id: driver.id,
        rider_id: params[:rider_id],
        current_latitude: latitude,
        current_longitude: longitude,
        target_latitude: params[:target_latitude],
        target_longitude: params[:target_longitude]
    )
  end
end
