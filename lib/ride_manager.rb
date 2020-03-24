require 'sequel'

class RideManager

  def initialize(current_location, target_location)
    @current_location = current_location
    @target_location = target_location
  end

  def request_ride(rider_id)
    available_drivers = Driver.where(available: TRUE)
    if available_drivers.any?
      driver = aviailable_drivers.last
      driver.update_fields({availaible: FALSE}, [:available])
      ride = Ride.create( status: "assigned", driver_id: driver.id, rider_id: rider_id,
                          current_latitude: @current_location[:latitude],
                          current_longitude: @current_location[:longitude],
                          target_latitude: @target_location[:latitude],
                          target_longitude: @target_location[:longitude],
                          start_time: Time.now,
                        )
      ride.update_fields({status: "in_progress"}, [:status])
      [:success, {:data => ride}]
    else
      [:error, {:error => "There isn't any available drivers, please try again in a few minutes"}]
    end
  end
end
