class ProductsController < ApplicationController
  def index
    @products = Product.all
    @carted_product = CartedProduct.new
  end

  def show
    @carted_product = CartedProduct.new
    @product = Product.find(params[:id])
  end
  
end
