class PaymentSource < Sequel::Model
plugin :validation_helpers

  many_to_one :rider

  def validate
    super
    validates_presence [:driver_id, :token, :reference]
  end
end
