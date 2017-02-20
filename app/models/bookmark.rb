class Bookmark < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  
  belongs_to :site

end
