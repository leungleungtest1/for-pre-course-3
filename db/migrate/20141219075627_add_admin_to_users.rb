class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    User.all.each {|user| user.update_columns(admin: false)}
  end
end
