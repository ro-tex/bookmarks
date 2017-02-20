class Bookmark < ApplicationRecord
  belongs_to :site

  validates :title, presence: true
  validates :url, presence: true

  after_initialize do
    self.site = Site.find_or_create_by!(url: URI.parse(self.url).host) unless self.url.nil?  
  end

end
