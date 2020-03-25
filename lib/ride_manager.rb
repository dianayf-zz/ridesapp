require 'sequel'

class RideManager

  def initialize(current_location, target_location)
    @current_location = current_location
    @target_location = target_location
  end

  def request_ride(rider_id)
     available_drivers = Driver.where(available: TRUE)
    if available_drivers.any?
      driver = available_drivers.last
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
    ride.update_fields({status: "finished", "ends_time": Time.now}, [:status, :ends_time])

    driver = ride.driver
    driver.update_fields({available: TRUE, 
                           current_latitude: @current_location[:latitude],
                           current_longitude: @current_location[:longitude]
                          }, [:available, :current_latitude, :current_longitude])

    rider = ride.rider
    rider.update_fields({current_latitude: @current_location[:latitude],
                           current_longitude: @current_location[:longitude]
                          }, [:current_latitude, :current_longitude])

    create_transaction(ride, rider)
  end

  def create_transaction(ride, rider)
    internal_ref = rand(36**8).to_s(36)

    amount = calculate_amount(ride).to_i
    ride.update_fields({amount: amount, status: "finished"}, [:amount, :status])

    source = rider.payment_sources.last
    Transaction.create(payment_source_id: source.id, internal_reference: internal_ref,
                       external_reference: "#{internal_ref}-pre",
                       created_at: Time.now,
                       amount: amount, status: "CREATED")

    MoneyTransaction.new.create_transaction(source.reference, amount, rider.email, source.token, internal_ref)
  end

  #distance_amount = (coordinate_difference) * 1000
  #initial suggestion, adds distance amount to calculate_amount
  def calculate_amount(ride)
    base_amount = 350000
    time_diff_sec = (ride.ends_time - ride.start_time)
    time_amount = ( time_diff_sec / 60).round * 20000
    base_amount + time_amount
  end
end
