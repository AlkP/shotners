class AddUsersColumnsToShotners < ActiveRecord::Migration
  def change
    change_table :shotners do |t|
      t.boolean :public_link
      t.string :password_link
      t.references :user, index: true
    end
  end
end
