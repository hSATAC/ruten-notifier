require './initializer.rb'
require 'pry'

desc "Run console"
task :c do
  ARGV.clear
  Pry::CLI.parse_options
end

namespace :db do
  desc "Run DB migration."
  task :migrate do
    CreateItemMigration.new.change
  end

  desc "Drop DB."
  task :drop do
    `rm -rf ./db/*.sqlite3`
  end
end
