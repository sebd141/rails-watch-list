class BookmarksController < ApplicationController
  before_action :find_bookmark, only: %i[edit show update destroy]

  def index
    @bookmarks = Bookmark.all
  end

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def edit
  end

  def update
    @bookmark.update(bookmark_params)
    @bookmark.list = @list
    redirect_to list_path(@list)
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark.destroy
    # no need for app/views/restaurants/destroy.html.erb
    redirect_to list_path(@bookmark.list)
  end
  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
