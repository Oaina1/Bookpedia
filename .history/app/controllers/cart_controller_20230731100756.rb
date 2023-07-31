class CartController < ApplicationController
  def add_to_cart
    book_id = params[:book_id]
    book = Book.find(book_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][book_id] ||= { name: book.name, price: book.price, quantity: 0 }
    session[:cart][book_id][:quantity] += 1

    redirect_to cart_path,flash: { added_success: 'Book added to cart successfully.' }
  end

  def index
  end


  def update_quantity
    book_id = params[:book_id]
    quantity = params[:quantity].to_i
    cart = session[:cart] || {}
    cart[product_id] = quantity
    session[:cart] = cart

    redirect_to cart_path, flash: { update_success: 'Product updated successfully.' }
  end

  def remove_item
    book_id = params[:book_id]
    session[:cart].delete(book_id)
    redirect_to cart_path, flash: { added_success: 'Book deleted from cart successfully.' }
  end



end
