require 'active_record'
require 'sqlite3'
require 'logger'
require 'net/smtp'
require 'yaml'
require './item.rb'
require './crawler.rb'

ActiveRecord::Base.logger = Logger.new('log/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(:development)
