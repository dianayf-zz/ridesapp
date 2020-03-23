require 'sequel'

Sequel.migration do
  change do
    create_table(:rides) do
      primary_key :id
      String :status
      DateTime :start_time
      DateTime :ends_time
      String :initial_latitude
      String :initial_longitude
      String :final_latitude
      String :final_longitude
      foreign_key :driver_id, :drivers
      foreign_key :rider_id, :riders
     end
  end 
end 
