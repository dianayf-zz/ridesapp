class Transaction < Sequel::Model
plugin :validation_helpers
plugin :json_serializer

  many_to_one :payment_sources

  def validate
    super
    validates_presence [:payment_source_id, :rider_id, :amount]
    validates_includes ["PENDING", "APPROVED", "DECLINED", "VOICED"], :status
  end
end
