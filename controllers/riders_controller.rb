require 'sequel'

class RidersController < Sinatra::Base

  get '/:id' do
    rider = Rider.where(id: params[:id])
    {message: "rides detail shown sucessfully", data: rider}.to_json
  end

  post '/ride/' do
    @json = JSON.parse(request.body.read)

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

  post '/payment_sources/' do
    @json = JSON.parse(request.body.read)

    case MoneyTransaction.new.create_payment_source
    in [:success, {data: data}]
      payment = PaymentSource.create(token: data["token"], reference: data["id"], rider_id: @json["rider_id"])
      {message: "payment source create sucessfully", data: payment}.to_json
    in [:error, {error: error}]
      {message: error, data: {}}.to_json
    end
  end
end
