class CheckoutController < ApplicationController

  def create
   # Get the cart details and calculate totals
   @cart-items = session[:cart] || {}
   @subtotal = calculate_subtotal
   @taxes = calculate_taxes(@subtotal)
   @total_price = @subtotal + @taxes
  end

def guest

end



def save_guest_details
  # Check if the form is submitted and handle the form submission
  if request.post?
    address_params = params[:address]

    # Validate the form fields
    if address_params[:address].blank? || address_params[:province].blank? || address_params[:name].blank?
      flash[:error] = 'Please fill in all the required fields.'
    else
      # Process the valid form submission and save the address to the session
      session[:guest_customer] = {
        name: address_params[:name],
        address: address_params[:address],
        province_id: address_params[:province_id]
      }

      redirect_to cart_path
      return
    end
  end

    # If the form submission is invalid or it's the first visit to the page, render the form
    @address ||= session[:guest_address] || {}
    @provinces_list = Province.all.map { |province| [province.name, province.id] }

    redirect_to guest_checkout_path, flash: { error: 'Please fill in all the required fields.' }
end

end
