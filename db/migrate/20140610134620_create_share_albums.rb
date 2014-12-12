class CreateShareAlbums < ActiveRecord::Migration
  def change
    create_table :share_albums do |t|
      t.integer :album_id
      t.integer :user_id

      t.timestamps
    end
  end
end
