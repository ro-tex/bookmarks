class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to bookmarks_url(@bookmark)
    else
      render 'new'
    end
  end

  def show
    if params.nil? || params[:format].nil?
      @bookmarks = Bookmark.all
      render 'index'
    else
      @bookmark = Bookmark.find(params[:format])
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:format])
  end

  def update
    @bookmark = Bookmark.find(params[:format])

    if @bookmark.update(bookmark_params)
      redirect_to bookmarks_url(@bookmark)
    else
      render 'edit'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:format])
    @bookmark.destroy
    redirect_to bookmarks_url
  end

  def search
    unless params[:search].nil?
      # Preserve the search query in the search bar:
      @search = OpenStruct.new(search_terms: search_params[:search_terms])

      # Should be formatted like this: '{"%AAA%", "%BBB%", "%CCC%"}'
      sql_search_pattern = search_params[:search_terms].split(' ').map { |p| "\"%#{p}%\"" }.join(', ')

      # See http://stackoverflow.com/questions/12957993/how-to-use-sql-like-condition-with-multiple-values-in-postgresql
      @bookmarks = Bookmark.where('url LIKE ANY (?) OR title LIKE ANY (?) OR shortening LIKE ANY (?)',
                                  "{#{sql_search_pattern}}", "{#{sql_search_pattern}}", "{#{sql_search_pattern}}")

      tags = Tag.where('name LIKE ANY (?)', "{#{sql_search_pattern}}")
      bookmarks_from_tags = tags.map(&:bookmarks).flatten

      @bookmarks += bookmarks_from_tags
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :shortening, :tags)
  end

  def search_params
    params.require(:search).permit(:search_terms)
  end
end
