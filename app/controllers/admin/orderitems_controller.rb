class Admin::OrderitemsController < ApplicationController
	def index
		@orderitems = Orderitem.all
	end

	def edit
		@orderitem = Orderitem.find(params[:id])
	end

	def update
		@orderitem = Orderitem.find(params[:id])
		post_params = params.require(:orderitem).permit(:status)
		@orderlist = Orderitem.where(receipt_id: @orderitem.receipt_id)
		@orderlist.each do |order|
			order.update(post_params)
		end
		# @orderitem.update(post_params)
		redirect_to admin_orderitems_path
	end

	def destroy
		@orderitem = Orderitem.find(params[:id])
		@orderitem.destroy
		redirect_to admin_orderitems_path
	end
end