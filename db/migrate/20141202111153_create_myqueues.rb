class CreateMyqueues < ActiveRecord::Migration
  def change
    create_table :myqueues do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
