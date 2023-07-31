class CheckoutController < ApplicationController

   # Get the cart details and calculate totals
   @cart = session[:cart] || {}
   @subtotal = calculate_subtotal
   @taxes = calculate_taxes(@subtotal)
   @total_price = @subtotal + @taxes

end
