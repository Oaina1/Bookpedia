class CartController < ApplicationController
  def add_to_cart
    book_id = params[:book_id]
    book = Product.find(book_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][book_id] ||= { name: book.name, price: book.price, quantity: 0 }
    session[:cart][book_id][:quantity] += 1

    redirect_to books_path, notice: "#{book.name} added to cart."
  end
end
