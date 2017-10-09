class Admin::ProductsController < ApplicationController

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			flash[:notice] = "Product successfully created"
			redirect_to admin_products_path
		else
			flash.now[:notice] = "Post not successfully created"
			render "new"
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			flash[:notice] = "Product successfully updated"
			redirect_to admin_products_path
		else
			flash.now[:notice] = "Product not successfully updated"
			render "edit"
		end
	end

	def destroy
		@product = Product.find(params[:id])
		if @product.destroy
			flash[:notice] = "Product successfully destroyed"
			redirect_to admin_products_path
		else
			flash[:notice] = "Product not successfully destroyed"
			render "index"
		end
	end

	private 
	def product_params
		params.require(:product).permit(:item_name, :price, :quantity, :image)
	end

end