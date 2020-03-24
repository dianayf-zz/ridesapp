Sequel.migration do
  change do
    create_table(:payment_sources) do
      primary_key :id
      String :token, :null => false, :unique => true
      String :reference, :null => false, :unique => true
      foreign_key :rider_id, :riders
      index [:rider_id]
    end
  end 
end
