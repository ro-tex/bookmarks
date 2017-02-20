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
    if defined?(params) && !params[:format].nil?
      @bookmark = Bookmark.find(params[:format])
    else
      @bookmarks = Bookmark.all
      render 'index'
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
  
  private
  
  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :shortening, :id)
  end
end
