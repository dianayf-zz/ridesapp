require 'sequel'

Sequel.migration do
  change do
    create_table(:rides) do
      primary_key :id
      String :status
      DateTime :start_time
      DateTime :ends_time
      String :current_latitude
      String :current_longitude
      String :target_latitude
      String :target_longitude
      foreign_key :driver_id, :drivers
      foreign_key :rider_id, :riders
     end
  end 
end 
