module BookmarksHelper
  def url_with_protocol(url)
    url.nil? || url.downcase.starts_with?('http') ? url : "http://#{url}"
  end
end
