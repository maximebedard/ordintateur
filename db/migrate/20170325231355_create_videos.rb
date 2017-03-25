class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :titre
      t.text :description
      t.string :video_url
      t.text :tags, array: true, default: []
      t.timestamps
    end
  end
end
