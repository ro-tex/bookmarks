include BookmarksHelper

class Bookmark < ApplicationRecord
  belongs_to :site
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :url, presence: true

  def save
    unless url.nil?
      # The URI library is having difficulties if the URL doesn't start with a protocol.
      top_level_domain = URI.parse(url_with_protocol(url)).host
      self.site = Site.find_or_create_by!(url: top_level_domain)
    end
    super
  end

  def tags=(tags)
    if tags.class == String
      # 'tags' is currently a comma-separated list of tag names.
      # We'll process each of them and create the ones we cannot find.
      # We'll then trigger the normal setter (super), so it can create
      # the relation objects we need.
      tags_array = tags.split(',').map { |tag_name| Tag.find_or_create_by(name: tag_name) }
      super(tags_array)
    else
      # In all other cases we'll let the default setter take care of things.
      super
    end
  end
end
