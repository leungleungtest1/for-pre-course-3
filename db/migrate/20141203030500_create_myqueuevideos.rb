class CreateMyqueuevideos < ActiveRecord::Migration
  def change
    create_table :myqueuevideos do |t|
      t.integer :video_id, :myqueue_id

      t.timestamps
    end
  end
end
