class DropQueues < ActiveRecord::Migration
  def change
    drop_table :queues
  end
end
