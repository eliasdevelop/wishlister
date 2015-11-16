class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :venue_name
      t.string :venue_photo
      t.integer :user_id

      t.timestamps
    end
  end
end
