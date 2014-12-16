class AddTokenUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string

    User.all.map {|user|
    user.update_column(:token, SecureRandom.urlsafe_base64)
    }
  end
end
