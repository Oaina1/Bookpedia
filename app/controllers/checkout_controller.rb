class CheckoutController < ApplicationController
    def create
      # Check if the cart is not empty
      if session[:cart].blank?
        redirect_to cart_path, flash: { error: 'Your cart is empty. Please add items before proceeding to checkout.' }
        return
      end

      # Calculate tax rates and total amount
      tax_rates = {}

      if customer_signed_in?
        customer_province = current_customer.province
      else
        customer_province = Province.find_by(id: session[:guest_province_id])
      end

      if customer_province
        tax_rates[:gst] = customer_province.gst
        tax_rates[:pst] = customer_province.pst
        tax_rates[:hst] = customer_province.hst
      end
      subtotal = 0
      session[:cart].each do |book_id, cart_item|
        book = Book.find(book_id)
        subtotal += book.price.to_f * cart_item['quantity'].to_i
      end
      tax_amount = (subtotal * (tax_rates[:gst].to_f + tax_rates[:pst].to_f + tax_rates[:hst].to_f)).round(2)
      total_amount = (subtotal + tax_amount).round(2)

      # Create the order
      @order = Order.create!(
        date: Date.current,
        total_amount: total_amount,
        gst: subtotal * (tax_rates[:gst].to_f).round(2),
        pst: subtotal * (tax_rates[:pst].to_f).round(2),
        hst: subtotal * (tax_rates[:hst].to_f).round(2),
        status: 'paid',
        customer_id: customer_signed_in? ? current_customer.id : nil,
      )

      # Create order items
      session[:cart].each do |book_id, cart_item|
        book = Book.find(book_id)
        @order.order_items.create(
          quantity: cart_item['quantity'].to_i,
          price: book.price.to_f,
          book_id: book.id
        )

      end

      # Clear the cart after successful order creation
      session.delete(:cart)

        redirect_to checkout_success_path
    end

def success
end

def guest
end


def save_guest_details
  # Check if the form is submitted and handle the form submission
  if request.post?

    # Validate the form fields
    if params[:address].blank? || params[:province_id].blank? || params[:name].blank?
      redirect_to guest_path, flash: { error: 'Please fill in all the required fields.' }
    else
      session[:guest_name] = params[:name]
      session[:guest_address] = params[:address]
      session[:guest_province_id] = params[:province_id]
      redirect_to cart_path
    end
  end
end

end
