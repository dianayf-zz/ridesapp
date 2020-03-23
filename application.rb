require 'sinatra/base'

Dir.glob('./config/*.rb').each { |file| require file }
Dir.glob('.app/{models, controllers}/*.rb').each { |file| require file }

map('/') { run HomeController }
map('/rides') { run RidesController }
map('/drivers') { run DriversController }
