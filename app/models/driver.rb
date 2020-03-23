class Driver < Sequel::Model
plugin :validation_helpers

  many_to_one :rides

  def validate
    super
    validates_presence [:name, :last_name, :email]
    validates_unique [:email]
    validates_format /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :email, message: 'is not a valid email, please verify'
    validates_max_length 10, :phone
  end
end
