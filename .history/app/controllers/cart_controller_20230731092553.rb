class CartController < ApplicationController
  def add_to_cart
    book_id = params[:book_id]
    book = Product.find(book_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][book_id] ||= { name: book.name, price: book.price, quantity: 0 }
    session[:cart][book_id][:quantity] += 1

    redirect_to books_path,flash: { added_success: 'Product added to cart successfully.' }
  end

  def show
  end


  def update_quantity
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    session[:cart][product_id][:quantity] = quantity
    redirect_to cart_path, notice: 'Cart updated.'
  end

  def remove_item
    product_id = params[:product_id]
    session[:cart].delete(product_id)
    redirect_to cart_path, notice: 'Item removed from cart.'
  end



end
