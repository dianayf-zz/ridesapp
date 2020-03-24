require 'httparty'

class MoneyTransaction

  def initialize
    @url = ENV["WOMPI_BASE_URL"]
  end


  def create_payment_source
    uri = URI.parse("#{@url}/payment_sources")
    payload = {"type" => "CARD", "token" => ENV["TOKENIZE_CARD"]}.to_json
    request = HTTParty.post(uri, :headers => {"Authorization" => "Bearer #{ENV["WOMPI_PRIVATE_KEY"]}",
                                             "Content-Type" => "application/json"
                                            }, :body => payload)
    make_request(request)
  end


  def create_transaction(source_id, amount, customer_email, token)
    uri = URI.parse("#{@url}/payment_sources")
    request = HTTParty.post(uri, :haders => {'Authorization' => "Bearer #{ENV["WOMPI_PRIVATE_KEY"]}",
                                             'Content-Type' => "application/json"
                                            }, :body => transaction_payload(source_id, amount, customer_email, token))
    make_request(request)
  end

  def validate_error(response)
    if response.code != 200
      [:error, {:error => response.parsed_response["error"]["reason"]}]
    else
      [:success, {:data => response.parsed_response["data"]}]
    end
  end
    
  def make_request(request)
    begin
      response = request
      validate_error(response)
    rescue HTTParty::Error => error
      [:error, {:error => error}]
    end
  end


private

  def transaction_payload(source_id, amount, customer_email, token)
    {
      "payment_source_id": source_id,
      "amount_in_cents": amount,
      "currency": "COP",
      "customer_email": customer_email,
      "reference": Digest::SHA1.new,
      "payment_method": {
        "type": "CARD",
        "token": token,  
        "installments": 2
      }
    }.to_json
  end

end
