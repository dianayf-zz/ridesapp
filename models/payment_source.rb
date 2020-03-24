class PaymentSource < Sequel::Model
plugin :json_serializer

  many_to_one :rider

  def validate
    super
    errors.add(:rider_id, 'cannot be empty') if !rider_id
    errors.add(:token, 'cannot be empty') if !token || token.empty?
    errors.add(:reference, 'cannot be empty') if !reference || reference.empty?
  end
end
