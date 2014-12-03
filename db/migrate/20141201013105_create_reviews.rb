class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :description
      t.integer :rating, :user_id, :video_id 

      t.timestamps
    end
  end
end
