class Driver < Sequel::Model
plugin :validation_helpers
plugin :json_serializer

  many_to_one :rides

  def validate
    super
    errors.add(:name, 'cannot be empty') if !name || name.empty?
    errors.add(:last_name, 'cannot be empty') if !last_name || last_name.empty?
    errors.add(:email, 'cannot be empty') if !email || email.empty?
    validates_unique [:email]
    validates_format /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :email, message: 'is not a valid email, please verify'
    validates_max_length 10, :phone
  end

end
