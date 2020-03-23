require 'sequel'
Sequel.migration do
  change do
    create_table(:riders) do
      primary_key :id
      String :name, :null => false
      String :last_name, :null => false
      String :email, :null => false
      String :phone, :unique => true
      String :current_latitude
      String :current_longitude
      index [:current_latitude, :current_longitude]
    end
  end 
end 
