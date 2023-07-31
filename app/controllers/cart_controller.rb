class CartController < ApplicationController
  def add_to_cart
    product_id = params[:product_id]
    product = Product.find(product_id)

    session[:cart] ||= {} # Initialize cart if not already present in the session
    session[:cart][product_id] ||= { name: product.name, price: product.price, quantity: 0 }
    session[:cart][product_id][:quantity] += 1

    redirect_to products_path, notice: "#{product.name} added to cart."
  end
end
