class CreateQueues < ActiveRecord::Migration
  def change
    create_table :queues do |t|
      t.integer :user
      
      t.timestamps
    end
  end
end
