class AddNewColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :country
    end
  end
end
