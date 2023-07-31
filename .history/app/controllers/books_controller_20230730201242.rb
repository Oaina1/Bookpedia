class BooksController < ApplicationController
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @books = @genre.books
      @association_name = @genre.name
  end

  def show
  end
end
