class ReceiptsController < ApplicationController
	TRANSACTION_SUCCESS_STATUSES = [
	    Braintree::Transaction::Status::Authorizing,
	    Braintree::Transaction::Status::Authorized,
	    Braintree::Transaction::Status::Settled,
	    Braintree::Transaction::Status::SettlementConfirmed,
	    Braintree::Transaction::Status::SettlementPending,
	    Braintree::Transaction::Status::Settling,
	    Braintree::Transaction::Status::SubmittedForSettlement,
	]

	def show
		@receipt = Receipt.find(params[:id])
		# @carted_products = CartedProduct.where(user_id: @receipt.user_id).order(:id)
		# if @carted_products != []
		# 	@carted_products.each do |carted_product|
		# 		@orderitem = Orderitem.new
		# 		@orderitem.product_id = carted_product.product_id
		# 		@orderitem.quantity = carted_product.quantity
		# 		@orderitem.receipt_id = @receipt.id
		# 		@orderitem.save
		# 	end
		# 	@carted_products.destroy_all
		# 	@orderitems = Orderitem.where(receipt_id: @receipt.id).order(:id)
		# else
		@orderitems = Orderitem.where(receipt_id: @receipt.id).order(:id)
		
		# @orderitems = Orderitem.new
		
		# @transaction = Braintree::Transaction.find(params[:id])
  		# @result = _create_result_hash(@transaction)
	end

	def _create_result_hash(transaction)
	    status = transaction.status

	    if TRANSACTION_SUCCESS_STATUSES.include? status
	      result_hash = {
	        :header => "Sweet Success!",
	        :icon => "success",
	        :message => "Your test transaction has been successfully processed. See the Braintree API response and try again."
	      }
	    else
	      result_hash = {
	        :header => "Transaction Failed",
	        :icon => "fail",
	        :message => "Your test transaction has a status of #{status}. See the Braintree API response and try again."
	      }
	    end
  	end
end