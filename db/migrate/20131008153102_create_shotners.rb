class CreateShotners < ActiveRecord::Migration
  def change
    create_table :shotners do |t|
      t.text :original_url
      t.text :shortened_url
      t.integer :usage_count

      t.timestamps
    end
  end
end
