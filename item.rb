class Item < ActiveRecord::Base
  OUT_OF_STOCK_PRICE = 50000

  STATUS_UNCHANGED = -1
  STATUS_NEW = 0
  STATUS_REFILL = 1
  STATUS_OUT_OF_STOCK = 2
  STATUS_CHANGE_PRICE = 3

  def self.import(data)
    item = Item.where(:ruten_id => data[:ruten_id]).first_or_initialize
    item.name = data[:name]
    item.price = data[:price]
    item.url = data[:url]
    data[:status] = item.status_before_save
    item.save
    logger.info "Item #{item.name} #{item.url} imported."
  end

  def self.batch_import(dataset)
    dataset.each { |data| Item.import(data) }
  end

  def status_before_save
    return STATUS_NEW unless self.persisted?
    return STATUS_UNCHANGED if self.price == self.price_was
    if self.price > OUT_OF_STOCK_PRICE && self.price_was < OUT_OF_STOCK_PRICE
      return STATUS_OUT_OF_STOCK
    elsif self.price < OUT_OF_STOCK_PRICE && self.price_was > OUT_OF_STOCK_PRICE
      return STATUS_REFILL
    else
      return STATUS_CHANGE_PRICE
    end
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
