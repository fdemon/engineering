class CreateWorkers < ActiveRecord::Migration
  def self.up
create_table :workers do |t|
  t.string :name
      t.string :worker_type
      t.string :phone
      t.string :recoord
  t.timestamps
end
  end

  def self.down
    drop_table :workers
  end
end
