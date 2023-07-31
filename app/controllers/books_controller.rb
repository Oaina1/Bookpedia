class BooksController < ApplicationController
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @books = @genre.books
      @association_name = @genre.name
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
