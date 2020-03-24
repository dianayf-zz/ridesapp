require 'sinatra/base'
require 'sinatra'
require 'sequel'

class DriversController <  Sinatra::Base

  post '/' do
    "creanding"
  end

  put '/' do
    "updating"
  end

  get '/:id' do
    driver = Driver.where(id: params[:id])
    {message: "driver detail shown sucessfully", data: driver}.to_json
  end

  post '/transactions/' do
    @json = JSON.parse(request.body.read)

    case MoneyTransaction.new.create_transaction(source_id, amount, customer_email, token)
    in [:success, {data: data}]
      s = PaymentSource.create(token: data.token, reference: data.id, rider_id: params[:rider_id])
      {message: "payment source create sucessfully", data: s}.to_json
    in [:error, {error: error}]
      {message: error, data: {}}.to_json
    end
  end

  not_found do
    {message: 'Not Found!'}.to_json
  end
end
