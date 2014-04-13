class Item < ActiveRecord::Base
  def self.import(data)
    item = Item.where(:ruten_id => data[3]).first_or_initialize
    item.name = data[1]
    item.price = data[2]
    item.url = data[0]
    item.save
    puts "Item #{item.name} #{item.url} imported."
  end

  def self.batch_import(dataset)
    dataset.each { |data| Item.import(data) }
  end
end

class CreateItemMigration < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.integer :price
      t.integer :ruten_id
      t.timestamps
    end

    add_index :items, :name
    add_index :items, :price
    add_index :items, :ruten_id
  end
end
