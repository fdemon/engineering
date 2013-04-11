class CreateProductItems < ActiveRecord::Migration
  def self.up
create_table :product_items do |t|
  t.integer :product_id
      t.integer :quantity
      t.float :price
      t.integer :purchasing_id
  t.timestamps
end
  end

  def self.down
    drop_table :product_items
  end
end
