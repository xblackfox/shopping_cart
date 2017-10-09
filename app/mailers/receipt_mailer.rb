class ReceiptMailer < ApplicationMailer

	def new_receipt(receipt)
		@receipt = receipt	
		mail to: @receipt.user.email, subject: 'Your order is on the way!'
	end
end