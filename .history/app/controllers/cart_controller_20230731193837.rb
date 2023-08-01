class CartController < ApplicationController
  def add_to_cart
    book_id = params[:book_id]
    book = Book.find(book_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][book_id] ||= { name: book.name, price: book.price, quantity:1 }

    redirect_to cart_path,flash: { add: 'Book added to cart successfully.' }
  end

  def index
    @tax_rates = {}
    @subtotal = 0

    if current_customer
      @customer_province = current_customer.province

      # Fetch tax rates from the province table for signed-in customers
      @tax_rates[:gst] = @customer_province.gst
      @tax_rates[:pst] = @customer_province.pst
      @tax_rates[:hst] = @customer_province.hst
    elsif session[:guest_province_id].present?
      # Fetch tax rates from the province table for guest customers (if available in session)
      guest_province = Province.find_by(id: session[:guest_province_id])
      if guest_province
        @tax_rates[:gst] = guest_province.gst
        @tax_rates[:pst] = guest_province.pst
        @tax_rates[:hst] = guest_province.hst
      end
    end

    # Calculate the tax amount

    @subtotal = session[:cart].sum { |_, cart_item| cart_item['price'].to_f * cart_item['quantity'] }
    @tax_amount = (@subtotal * (@tax_rates[:gst].to_f + @tax_rates[:pst].to_f + @tax_rates[:hst].to_f)).round(2)

    # Calculate the total amount after adding tax
    @total_amount = (@subtotal + @tax_amount).round(2)
  end


  def update_quantity
    book_id = params[:book_id]
    quantity = params[:quantity].to_i
    session[:cart][book_id][:quantity] = quantity
    redirect_to cart_path, flash: { update: 'Book quantiy updated successfully.' }
  end

  def remove_item
    book_id = params[:book_id]
    session[:cart].delete(book_id)
    redirect_to cart_path, flash: { delete: 'Book deleted from cart successfully.' }
  end



end
