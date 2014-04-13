require 'active_record'
require 'sqlite3'
require 'logger'

class Schema < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :state
    end

    add_index :users, :name
  end
end

namespace :db do
  desc "Run DB migration."
  task :migrate do
    ActiveRecord::Base.logger = Logger.new('log/debug.log')
    ActiveRecord::Base.configurations = YAML::load(IO.read('database.yml'))
    ActiveRecord::Base.establish_connection(:development)
    Schema.new.change
  end
end
