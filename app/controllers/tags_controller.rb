class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    if defined?(params) && !params[:format].nil?
      @tag = Tag.find(params[:format])
    else
      @tag = Tag.all
      render 'index'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :id)
  end
end
