class CheckoutController < ApplicationController

  def create

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
