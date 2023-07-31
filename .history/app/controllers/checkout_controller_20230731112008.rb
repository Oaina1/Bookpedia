class CheckoutController < ApplicationController

   # Get the cart details and calculate totals
   @cart-items = session[:cart] || {}
   @subtotal = calculate_subtotal
   @taxes = calculate_taxes(@subtotal)
   @total_price = @subtotal + @taxes



end

def save_guest_address
  # Check if the form is submitted and handle the form submission
  if request.post?
    address_params = params[:address]

    # Validate the form fields
    if address_params[:address_line1].blank? || address_params[:city].blank? || address_params[:province].blank? || address_params[:postal_code].blank?
      flash[:error] = 'Please fill in all the required fields.'
    else
      # Process the valid form submission and save the address to the session
      session[:guest_address] = address_params

      redirect_to checkout_index_path
      return
    end
  end

    # If the form submission is invalid or it's the first visit to the page, render the form
    @address ||= session[:guest_address] || {}
    @provinces_list = Province.all.map { |province| [province.name, province.id] }

    redirect_to checkout_guest_path, flash: { error: 'Please fill in all the required fields.' }
end
