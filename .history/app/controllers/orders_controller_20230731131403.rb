class OrdersController < ApplicationController
  def index
    if customer_signed_in?
      @orders = current_customer.orders.includes(:order_items, :customer, order_items: :book)
    else
      # Handle the case where the customer is not signed in, or redirect to login.
      # For example:
      redirect_to new_customer_session_path, notice: "Please sign in to view your orders."
    end
  end
end
