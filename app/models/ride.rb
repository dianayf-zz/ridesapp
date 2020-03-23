class Ride < Sequel::Model
plugin :validation_helpers

  many_to_one :rider
  many_to_one :driver

  def validate
    super
    validates_presence [:driver_id, :rider_id]
    validates_includes [:available, :in_progress, :finished], :status
  end
end
