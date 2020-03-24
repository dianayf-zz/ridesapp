require 'sinatra/base'
require './ridesapp'

Dir.glob('./{config,controllers,lib,models}/*.rb').each { |file| require file }

map('/') { run HomeController }
map('/drivers') { run DriversController }
map('/riders') { run RidersController }
map('/rides') { run RidesController }
