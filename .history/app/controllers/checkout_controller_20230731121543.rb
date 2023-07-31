class CheckoutController < ApplicationController

  def create
   # Get the cart details and calculate totals
   @cart-items = session[:cart] || {}
   @subtotal = calculate_subtotal
   @taxes = calculate_taxes(@subtotal)
   @total_price = @subtotal + @taxes
  end

def guest
  # Fetch the list of provinces for the dropdown select menu
  @provinces_list = Province.all.map { |province| [province.name, province.id] }

end



def save_guest_details
  # Check if the form is submitted and handle the form submission
  if request.post?

    # Validate the form fields
    if params[:address].blank? || params[:province].blank? || params[:name].blank?
      redirect_to guest_path, flash: { error: 'Please fill in all the required fields.' }
    else
      # Process the valid form submission and save the address to the session
      session[:guest_customer] = {
        name: params[:name],
        address: params[:address],
        province_id: params[:province]
      }
      redirect_to cart_path
      return
    end
  end
end

end
