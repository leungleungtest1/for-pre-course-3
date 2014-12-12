class CreateFolloweeships < ActiveRecord::Migration
  def change
    create_table :followeeships do |t|
      t.integer :user_id, :followee_id

      t.timestamps
    end
  end
end
