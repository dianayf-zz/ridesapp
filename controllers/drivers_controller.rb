require 'sinatra/base'
require 'sinatra'
require 'sequel'

class DriversController < Sinatra::Base

  get '/:id' do
    driver = Driver.where(id: params[:id])
    {message: "driver detail shown successfully", data: driver}.to_json
  end

  put '/rides/:id' do
    @json = JSON.parse(request.body.read)
    ride = Ride.first(id: id)

    case RideManager.new(current_location, target_location).finish_ride(ride)
    in [:success, {data: data}]
    {message: "ride finished successfully", data: ride}.to_json
    in [:error, {error: error}]
      {message: error, data: {}}.to_json
    end
  end

  post '/transactions/' do
    @json = JSON.parse(request.body.read)

    case MoneyTransaction.new.create_transaction(source_id, amount, customer_email, token)
    in [:success, {data: data}]
      s = PaymentSource.create(token: data.token, reference: data.id, rider_id: params[:rider_id])
      {message: "payment source create successfully", data: s}.to_json
    in [:error, {error: error}]
      {message: error, data: {}}.to_json
    end
  end

  not_found do
    {message: 'Not Found!'}.to_json
  end
end
