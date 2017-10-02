class ProductsController < ApplicationController

  before_action :find_product, only: [:show, :edit, :update, :destroy]

   def index
     @prod = Product.all
   end

   def new
     @prod = Product.new
   end

   def create
      @prod = Product.new(product_params)

      if @prod.save
        redirect_to @prod
      else
        render 'new'
    end
  end

  def show

  end

  def edit
  end

  def update
    if @prod.update(product_params)
      redirect_to @prod
    else
      render 'edit'
    end
  end

  def destroy
    @prod.destroy
    redirect_to products_path
  end

    private

    def product_params
      params.require(:product).permit(:item_name, :price, :image, :quantity)
    end

    def find_product
      @prod = Product.find(params[:id])
    end

  
end
