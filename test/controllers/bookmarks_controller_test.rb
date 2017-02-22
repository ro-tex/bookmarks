require 'test_helper'

class BookmarksControllerTest < ActionDispatch::IntegrationTest
  def test_search
    get '/search'
    assert_equal 200, status

    # searching by title
    post '/search', params: { search: { search_terms: 'Rails Guide' } }
    assert_response :success
    assert_select 'h4', 'Rails Guide'

    # searching by url
    post '/search', params: { search: { search_terms: 'guides' } }
    assert_response :success
    assert_select 'h4', 'Rails Guide'

    # searching by shortening
    post '/search', params: { search: { search_terms: 'goo.gl' } }
    assert_response :success
    assert_select 'h4', 'Rails Guide'

    # searching by tag
    post '/search', params: { search: { search_terms: 'tech' } }
    assert_response :success
    assert_select 'h4', 'Rails Guide'

    # searching by a combination - tag and url
    post '/search', params: { search: { search_terms: 'tech components' } }
    assert_response :success
    assert_select 'h4', 'Rails Guide'
    assert_select 'h4', 'Bootstrap'
  end
end
