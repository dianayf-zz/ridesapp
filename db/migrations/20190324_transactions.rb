Sequel.migration do
  change do
    create_table(:transactions) do
      primary_key :id
      String :status
      String :internal_reference, :null => false, :unique => true
      String :external_reference, :null => false, :unique => true
      Integer :amount, :null => false
      DateTime :created_at, :null => false
      foreign_key :payment_source_id, :payment_sources
      index [:payment_source_id]
     end
  end 
end 
