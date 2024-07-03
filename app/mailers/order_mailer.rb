class OrderMailer < ApplicationMailer
	def order_completed(user)
		@user = user
		mail(to: "abhishekg@witmates.com", subject: "your orders completed")
	end
end
