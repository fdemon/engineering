class CreateProducts < ActiveRecord::Migration
  def self.up
create_table :products do |t|
  t.string :name
      t.integer :unit_id
      t.string :product_type
      t.string :record
  t.timestamps
end
  end

  def self.down
    drop_table :products
  end
end
