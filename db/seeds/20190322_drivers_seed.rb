Sequel.seed do
  def run
    [
      ["juan", "jacobo", "3205999399", "juanjacobo@email.com", "4.666042", "-74.130263", 1],
      ["jose", "hernandez", "3206699399", "jesus@email.com", "4.650914", "-74.127891", 1],
      ["michael", "garzon", "3233232338" ,"garzon_mi@email.com", "4.668889", "-74.092024", 1],
      ["sebastian", "reyes", "3535232335" ,"sebas_re@email.com", "4.688266", "-74.064259", 1],
      ["ariadna", "leon", "3109399989", "lariadnal@email.com", "4.709432", "-74.040305", 1],
      ["andres", "fuentes", "245500000", "sourcesf@email.com", "4.751479", "-74.046000", 1],
      ["mario", "mendoza", "9093434322", "mariom@email.com", "4.652162", "-74.060382", 1]
    ].each do |name, last_name, phone, email, latitude, longitude, available|
      Driver.create(name: name, last_name: last_name, phone: phone, email: email, current_latitude: latitude, current_longitude: longitude, available: available)
    end
   end
end 
