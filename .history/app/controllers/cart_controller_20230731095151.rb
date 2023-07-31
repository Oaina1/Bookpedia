class CartController < ApplicationController

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
