class CustomerController < ApplicationController
  def show
    before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
  end
  end
end
