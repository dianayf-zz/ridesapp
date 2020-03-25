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


  def create_transaction(source_id, amount, customer_email, token, internal_ref)
    uri = URI.parse("#{@url}/transactions")
    request = HTTParty.post(uri, :headers => {"Authorization" => "Bearer #{ENV["WOMPI_PRIVATE_KEY"]}",
                                             "Content-Type" => "application/json"
                                            }, :body => transaction_payload(source_id, amount, customer_email, token, internal_ref))
    make_request(request)
  end

  def validate_error(response)
    if [200, 201].include? response.code
      [:success, {:data => response.parsed_response["data"]}]
    else
      [:error, {:error => response.parsed_response["error"]["reason"]}]
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

  def transaction_payload(source_id, amount, customer_email, token, internal_ref)
    {
      "payment_source_id" => source_id,
      "amount_in_cents" => amount,
      "currency" => "COP",
      "customer_email" => customer_email,
      "reference" => internal_ref,
      "payment_method" => {
        "type" => "CARD",
        "token" => token,
        "installments" => 2
      }
    }.to_json
  end

end
