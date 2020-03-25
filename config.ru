require 'sinatra/base'
require './ridesapp'

Dir.glob('./{config,controllers,models,lib}/*.rb').sort.each { |file| require file }

map('/') { run HomeController }
map('/drivers') { run DriversController }
map('/riders') { run RidersController }
map('/rides') { run RidesController }
