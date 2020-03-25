require 'sequel'

class RidersController < Sinatra::Base

  get '/:id' do
    rider = Rider.where(id: params[:id])
    {message: "rides detail shown successfully", data: rider}.to_json
  end

  post '/rides/' do
    @json = JSON.parse(request.body.read)

    case RideManager.new(@json["current_location"], @json["target_location"]).request_ride(@json["rider_id"])
    in [:success, {data: data}]
      {message: "ride created successfully", data: data}.to_json
    in [:error, {error: error}]
      {message: error, data: {}}.to_json
    end
  end

  post '/payment_sources/' do
    @json = JSON.parse(request.body.read)

    case MoneyTransaction.new.create_payment_source
    in [:success, {data: data}]
      payment = PaymentSource.create(token: data["token"], reference: data["id"], rider_id: @json["rider_id"])
      {message: "payment source created successfully", data: payment}.to_json
    in [:error, {error: error}]
      {message: error, data: {}}.to_json
    end
  end

  not_found do
    {message: 'Not Found!'}.to_json
  end
end
