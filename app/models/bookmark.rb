class Bookmark < ApplicationRecord
  belongs_to :site
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :url, presence: true

  def save
    self.site = Site.find_or_create_by!(url: URI.parse(self.url).host)
    super
  end
end
