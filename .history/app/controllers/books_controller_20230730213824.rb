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
        @books = @books.where(on_sale: true)
      end
    end
    # @books = @books.page(params[:page]).per(15)
  end


  def search
    @books = Book.all

    if params[:genre_id].present? && params[:keyword].present?
      @books = @books.where(genre_id: params[:genre_id])
                           .where('name LIKE ?', "%#{params[:keyword]}%")
    elsif params[:genre_id].present?
      @bookss = @genres.where(genre_id: params[:genre_id])
    elsif params[:keyword].present?
      @products = @products.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @products = @products
    end
    @total_results = @products.size
    @products = @products.page(params[:page]).per(15)
  end
end