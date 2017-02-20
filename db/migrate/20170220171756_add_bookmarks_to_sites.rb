class AddBookmarksToSites < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookmarks, :site, foreign_key: true
  end
end
