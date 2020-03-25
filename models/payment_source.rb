class PaymentSource < Sequel::Model
plugin :validation_helpers
plugin :json_serializer

  many_to_one :rider

  def validate
    super
    validates_presence [:rider_id, :token, :reference]
  end
end
