require './initializer.rb'


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
