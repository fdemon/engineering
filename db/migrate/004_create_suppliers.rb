class CreateSuppliers < ActiveRecord::Migration
  def self.up
create_table :suppliers do |t|
  t.string :name
      t.string :contactor
      t.string :phone
      t.string :supplier_type
      t.string :record
  t.timestamps
end
  end

  def self.down
    drop_table :suppliers
  end
end
