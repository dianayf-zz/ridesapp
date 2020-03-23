Sequel.seed do
  def run
    [
      ["juan", "jimenez", "4529022334", "juanito@email.com", "4.700813", "-74.115046"],
      ["jose", "sanchez", "9898983737", "jose@email.com", "4.680514", "-74.082027"],
      ["carolina", "lopez", "9090909039", "carito@email.com", "4.688017", "-74.058369"],
      ["andrea", "diaz", "2626262888", "andreitad@email.com", "4.707070", "-74.051968"],
      ["alfonso", "rios", "2726363638", "alfonsori@email.com", "4.652095", "-74.138387"],
      ["diana", "florian", "2722263638", "dianita@email.com", "4.625294", "-74.065400"]
    ].each do |name, last_name, phone, email, latitude, longitude|
      Rider.create(name: name, last_name: last_name, phone: phone,  email: email, current_latitude: latitude, current_longitude: longitude)
    end
   end
end 
