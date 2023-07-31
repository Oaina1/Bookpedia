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

  def filter
    @books = Book.all

    if params[:filter].present?
      case params[:filter]
      when 'recntly_updated'
        @books = @books.where('updated_at >= ?', 3.days.ago)
      when 'on_sale'
        @books = @books.where(on_sale_status: true)
      end
    end
    # You may also want to paginate the results
    # @books = @books.page(params[:page]).per(15)
  end
end
