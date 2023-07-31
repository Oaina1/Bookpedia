class CartController < ApplicationController
  def add_to_cart
    book_id = params[:book_id]
    book = Book.find(book_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][book_id] ||= { name: book.name, price: book.price, quantity:1 }

    redirect_to cart_path,flash: { added_success: 'Book added to cart successfully.' }
  end

  def index
  end


  def update_quantity
    book_id = params[:book_id]
    quantity = params[:quantity].to_i
    session[:cart][book_id][:quantity] = quantity
    redirect_to cart_path, flash: { added_success: 'Book quantiy updated successfully.' }
  end

  def remove_item
    book_id = params[:book_id]
    session[:cart].delete(book_id)
    redirect_to cart_path, flash: { added_success: 'Book deleted from cart successfully.' }
  end



end
