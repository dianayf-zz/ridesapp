class Rider < Sequel::Model
plugin :validation_helpers

  one_to_many :rides
  one_to_many :payment_sources

  def validate
    super
    validates_presence [:name, :last_name, :email]
    validates_unique [:email]
    validates_format /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :email, message: 'is not a valid email, please verify'
    validates_max_length 10, :phone
  end
end
