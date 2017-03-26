class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :seconds_from_start
      t.text :description
      t.timestamps
    end
  end
end
