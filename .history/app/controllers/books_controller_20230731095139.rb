class BooksController < ApplicationController
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @books = @genre.books.page(params[:page]).per(10)
      @association_name = @genre.name
    else
      @books = Book.page(params[:page]).per(10)
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
    @books = @books.page(params[:page]).per(10)
  end


  def search
    @books = Book.all

    if params[:genre_id].present? && params[:keyword].present?
      @books = @books.where(genre_id: params[:genre_id])
                           .where('name LIKE ?', "%#{params[:keyword]}%")
    elsif params[:genre_id].present?
      @books = @books.where(genre_id: params[:genre_id])
    elsif params[:keyword].present?
      @books = @books.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @books = @books
    end
    @result_count = @books.size
    @books = @books.page(params[:page]).per(10)
  end

  def add_to_cart
    book_id = params[:book_id]
    book = Product.find(book_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][book_id] ||= { name: book.name, price: book.price, quantity: 0 }
    session[:cart][book_id][:quantity] += 1

    redirect_to cart_path,flash: { added_success: 'Book added to cart successfully.' }
  end
end
