class CreateJoinTableTagPhoto < ActiveRecord::Migration
  def change
    create_join_table :tags, :photos do |t|
      t.index [:tag_id, :photo_id]
      t.index [:photo_id, :tag_id]
    end
  end
end
