class CreateJoinTableTagBookmark < ActiveRecord::Migration[5.0]
  def change
    create_join_table :tags, :bookmarks do |t|
      # t.index [:tag_id, :bookmark_id]
      # t.index [:bookmark_id, :tag_id]
    end
  end
end
