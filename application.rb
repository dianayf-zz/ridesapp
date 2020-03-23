require 'sinatra/base'

Dir.glob('.app/{config, models, controllers}/*.rb').each { |file| require file }

map('/') { run HomeController }
map('/rides') { run RidesController }
map('/drivers') { run DriversController }
