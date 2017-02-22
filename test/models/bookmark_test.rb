require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test 'creation' do
    assert_not Site.exists?(url: 'www.duolingo.com'), 'Make sure a site object does not exist yet.'

    bookmark = Bookmark.new
    assert_not bookmark.save, 'Saved an empty bookmark.'

    bookmark.title = 'Duo'
    assert_not bookmark.save, 'Saved a bookmark with a title but no URL.'

    bookmark.title = nil
    bookmark.url = 'https://www.duolingo.com/'
    assert_not bookmark.save, 'Saved a bookmark with a URL but no title.'

    bookmark.title = 'Duo'
    assert bookmark.save, 'Saved a bookmark with a title and URL.'
    assert Site.exists?(url: 'www.duolingo.com'), 'Make sure a site object was created with the bookmark.'
  end

  test 'tag_association_from_bootstrap_array' do
    # This is how Bootstrap sends the list of tags:
    bootstrap_tag_list = 'technical,non_existent'

    assert_not Tag.exists?(name: 'non_existent'), 'The tag "non_existent" does not exist yet.'

    bootstrap_bookmark = Bookmark.find_by(title: 'Bootstrap') # from fixture
    bootstrap_bookmark.tags = bootstrap_tag_list

    tag_technical = Tag.find_by(name: 'technical') # from fixture
    assert bootstrap_bookmark.tags.include?(tag_technical), 'The existing tag "technical" has been applied.'

    assert Tag.exists?(name: 'non_existent'), 'The tag "non_existent" that did not exist before was created.'
    tag_non_existent = Tag.find_by(name: 'non_existent')
    assert bootstrap_bookmark.tags.include?(tag_non_existent), 'The tag "non_existent" has been applied.'
  end
end
