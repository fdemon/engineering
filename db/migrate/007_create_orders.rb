class CreateOrders < ActiveRecord::Migration
  def self.up
create_table :orders do |t|
  t.date :pay_date
      t.integer :supplier_id
      t.integer :worker_id
      t.string :pay_type
      t.float :moneyofpayed
      t.float :moneyofdiscount
      t.string :record
  t.timestamps
end
  end

  def self.down
    drop_table :orders
  end
end
