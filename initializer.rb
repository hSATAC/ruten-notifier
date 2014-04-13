require 'active_record'
require 'sqlite3'
require 'logger'
require './item.rb'
require './crawler.rb'

puts "Initializing..."

ActiveRecord::Base.logger = Logger.new('log/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('database.yml'))
ActiveRecord::Base.establish_connection(:development)
