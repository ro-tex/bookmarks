class BookmarksController < ApplicationController
    
    def index
      @bookmarks = Bookmark.all
    end
    
    def new
      @bookmark = Bookmark.new
    end
    
    def create
      @bookmark = Bookmark.new(bookmark_params)
      
      # TODO build a site based on the URL
      
      if @bookmark.save
        redirect_to bookmarks_url(@bookmark)
      else
        render 'new'
      end
    end

    private
    
    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :shortening)
    end
    
end
