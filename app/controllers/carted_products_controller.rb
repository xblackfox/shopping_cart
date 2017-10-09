class CartedProductsController < ApplicationController
	# require "rubygems"
	# # require "braintree"

	# Braintree::Configuration.environment = :sandbox
	# Braintree::Configuration.merchant_id = ENV["BRAINTREE_MERCHANT_ID"]
	# Braintree::Configuration.public_key = ENV["BRAINTREE_PUBLIC_KEY"]
	# Braintree::Configuration.private_key = ENV["BRAINTREE_PRIVATE_KEY"]

	def index
		@carted_products = CartedProduct.all
		@client_token = Braintree::ClientToken.generate
		@carted_product_total_price = carted_product_total_price
	end

	def create
		# find for existing cartedproduct records
		if CartedProduct.find_by(product_id: params[:product_id])==nil
			@carted_product = CartedProduct.new(carted_products_params)
			@carted_product.user_id = current_user.id
			@carted_product.product_id = params[:product_id]

			if @carted_product.save
				flash[:notice] = "Item added Successfully"
				redirect_to carted_products_path
			else
				@products = Product.all 
				flash.now[:notice] = "Unsuccessful, please check quantity input"
				render "products/index"
			end
		else
			@carted_product = CartedProduct.find_by(product_id: params[:product_id])
			@temp_carted_product = CartedProduct.new(carted_products_params)
			@carted_product.quantity += @temp_carted_product.quantity

			if @carted_product.save
				flash[:notice] = "Item added Successfully"
				redirect_to carted_products_path
				# redirect_to checkout_path(result.transaction.id)
			else
				@products = Product.all 
				flash.now[:notice] = "Unsuccessful, please check quantity input"
				render "products/index"
			end
			# if @carted_product.update(carted_products_params)
			# 	flash[:notice] = "Carted Item Updated Successfully"
			# 	redirect_to carted_products_path
			# else
			# 	flash.now[:notice] = "Carted Item cannot be updated"
			# 	render "carted_products/edit"
			# end
		end		
		# # bec schema has t.string for product.quantity, so to_i
		# @quantity = Product.find(@carted_product.product_id).quantity.to_i

		# if @carted_product.quantity > @quantity
		# 	@products = Product.all 
		# 	flash.now[:notice] = "Unsuccessful, please check quantity input"
		# 	render "products/index"
		# 	return
		# end

	end

	def edit
		@carted_product = CartedProduct.find(params[:id])
	end 

	def update
		@carted_product = CartedProduct.find(params[:id])
		if @carted_product.update(carted_products_params)
			flash[:notice] = "Carted Item Updated Successfully"
			redirect_to carted_products_path
		else
			flash.now[:notice] = "Carted Item cannot be updated"
			render "carted_products/edit"
		end					
	end

	def destroy
		@carted_product = CartedProduct.find(params[:id])
		if @carted_product.destroy
			flash[:notice] = "Carted Item destroyed Successfully"
			redirect_to carted_products_path
		else
			flash.now[:notice] = "Carted Item cannot be Destroyed"
			render "carted_products/index"
		end
	end

	def checkouts

	    amount = params["amount"] # In production you should not take amounts directly from clients
	    nonce = params["payment_method_nonce"]

	    result = Braintree::Transaction.sale(
	      amount: amount,
	      payment_method_nonce: nonce,
	      :options => {
	        :submit_for_settlement => true
	      }
	    )

	    if result.success? || result.transaction
	      @receipt = Receipt.new
	      @receipt.totalcost = result.transaction.amount.to_f
	      @receipt.user_id = current_user.id
	      
	      	if @receipt.save
			    #create a orderitem list
				@carted_products = CartedProduct.where(user_id: @receipt.user_id).order(:id)
				@carted_products.each do |carted_product|
					@orderitem = Orderitem.new
					@orderitem.product_id = carted_product.product_id
					@orderitem.quantity = carted_product.quantity
					@orderitem.receipt_id = @receipt.id
					@orderitem.save
				end
				#destroy the cart
				@carted_products.destroy_all

				#send mail to user for orderitems
				ReceiptMailer.new_receipt(@receipt).deliver_now

		    	redirect_to receipt_path(@receipt.id)
		    	# redirect_to checkout_path(result.transaction.id)
	    	end	

	    else
	      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
	      flash[:error] = error_messages
	      redirect_to new_checkout_path
	    end
	end

	private 
	def carted_products_params
		params.require(:carted_product).permit(:quantity)
	end

	def carted_product_total_price
		total_price = 0
		@carted_products.each{|carted_product| 
			row_carted_price = carted_product.product.price * carted_product.quantity;
			total_price += row_carted_price
		}
		total_price
	end
end