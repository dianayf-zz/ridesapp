class DriverAssigner < Sinatra::Base

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

end
