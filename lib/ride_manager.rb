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

  def finish_ride(ride)
    ride.update_fields({status: "finished", "ends_at": Time.now}, [:status, :ends_at])

    driver = ride.driver_id
    driver.update_fields({available: TRUE, 
                           current_latitude: @current_location[:latitude],
                           current_longitude: @current_location[:longitude]
                          }, [:available, :current_latitude, :current_longitude])

    rider = ride.rider
    rider.update_fields({current_latitude: @current_location[:latitude],
                           current_longitude: @current_location[:longitude]
                          }, [:current_latitude, :current_longitude])

    amount = calculate_amount(ride)
    source = rider.payment_sources.last

    ride.update_fields({amount: "in_progress"}, [:status])
    MoneyTransaction.new.create_transaction(source.id, amount, rider.email, source.token)
  end

  def time_difference(ride)
    t1 = Time.parse(ride.start_at)
    t2 = Time.parse(ride.ends_at)
    t2 - t1
  end

  def calculate_amount(ride)
    base_amount = 3500
    distance_amount = (coordinate_difference) * 1000
    time_amount = (time_differentece(ride) / 60) * 200
    base_amount + distance_amount + time_amount
  end
end
