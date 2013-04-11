class AlertProductItems < ActiveRecord::Migration
  def self.up
    rename_column :product_items, :purchasing_id, :order_id
  end

  def self.down
    raname_column :product_items, :order_id, :purchasing_id
  end
end
