
class Item < ActiveRecord::Base

end

class CreateItemMigration < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.integer :price
      t.timestamps
    end

    add_index :items, :name
    add_index :items, :price
  end
end
